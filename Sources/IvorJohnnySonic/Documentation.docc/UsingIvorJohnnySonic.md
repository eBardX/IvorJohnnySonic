# Using IvorJohnnySonic

Take JohnnySonic score bytes from `Data` to a validated syntax tree.

## Overview

IvorJohnnySonic exposes four processing types. Each is a `Sendable` value type
with a no-argument initializer and a single primary method:

 Type              | Method                | Result
:----              |:------                |:------
 ``DKMParser``     | `parse(_:)`           | `(DKMScore, [DKMParser.Diagnostic])`
 ``DKMNormalizer`` | `normalize(_:)`       | `(DKMScore, [DKMNormalizer.Change])`
 ``DKMValidator``  | `validate(_:)`        | `(DKMScore, [DKMValidator.Issue])`
 ``DKMFormatter``  | `format(_:)`          | `Data`

A ``DKMScore`` carries two Boolean state flags that enforce the order of the
pipeline:

- **`isNormalized`** — `validate(_:)` throws unless this is `true`.
- **`isValidated`** — `format(_:)` throws unless this is `true`.

So the canonical order is **parse → normalize → validate → format**:

```swift
let (parsed, diagnostics) = try DKMParser().parse(data)
let (normalized, changes) = DKMNormalizer().normalize(parsed)
let (validated, issues)   = try DKMValidator().validate(normalized)

guard issues.isEmpty
else { /* handle issues */ return }

let output = try DKMFormatter().format(validated)
```

Both `normalize(_:)` and `validate(_:)` are idempotent — calling them on a
score that is already normalized or validated returns it unchanged — so it is
always safe to run the full pipeline.

### The reference implementation

JohnnySonic’s own C implementation lives at
[`../../JohnnySonic`](https://github.com/JohnnySonic/JohnnySonic) alongside
this package, and its `main.c` is the semantic authority this package is
checked against: where the format’s own documentation is silent or ambiguous,
`main.c`’s behavior — including its recoveries, its clamps, and its hard
errors — is what IvorJohnnySonic reproduces. Several corrections to this
package’s own earlier doc comments trace back to reading that source directly
rather than the format’s PDF documentation alone.

## Parsing

``DKMParser`` decodes raw UTF-8 text data into a ``DKMScore``:

```swift
let (score, diagnostics) = try DKMParser().parse(data)
```

The parser is tolerant of two specific, provably-safe deviations from the
reference implementation’s own conventions, and reports each repair as a
``DKMParser/Diagnostic``: a `` `/GEQ` `` line whose band-gain count does not
match the reference’s fixed 30, and an integer-typed parameter (such as
`numberOfVoices`) written with a fractional part, which the reference itself
reads as a `double` and truncates. Diagnostics are always returned, never
thrown; each has a human-readable `message`:

```swift
for diagnostic in diagnostics {
    print(diagnostic.message)
}
```

The parser throws ``DKMParser/Error`` when the data cannot be decoded at
all — invalid UTF-8, a data line with the wrong parameter count or an
unparseable value, an unrecognized section name, or a data line before any
section has been established:

```swift
do {
    let (score, _) = try DKMParser().parse(data)
} catch let error as DKMParser.Error {
    print(error.message)
}
```

## Normalizing

``DKMNormalizer`` mechanically canonicalizes a score, returning a new score
whose `isNormalized` flag is `true`, together with a list of the changes it
applied:

```swift
let (normalized, changes) = DKMNormalizer().normalize(score)

for change in changes {
    print(change.message)        // what was changed
    print(change.commandIndex)   // which command in the input score, if any
}
```

Canonical form clamps a negative start beat or duration to zero on every
command except a note, rewrites a `` `/Levels` `` line’s continuation start
beat (a negative value, meaning “continue from where the previous `/Levels`
line ended”) to the absolute beat it resolves to, and drops a
``DKMCommand/haas(_:)``, ``DKMCommand/tuning(_:)``,
``DKMCommand/soundFileName(_:)``, or ``DKMCommand/screenOut(_:)`` command that
merely restates the value already in effect. A negative start beat on a note
is left alone — in the reference implementation it terminates the score
rather than requesting a repair, and clamping it would silently discard that
meaning. See ``DKMNormalizer/normalize(_:)`` for the full list of changes
considered and rejected.

## Validating

``DKMValidator`` checks a **normalized** score against the reference
implementation’s parameter constraints:

```swift
let (validated, issues) = try DKMValidator().validate(normalized)

if issues.isEmpty {
    // `validated.isValidated` is now true.
} else {
    issues.forEach { print($0.message) }
}
```

- If the score has not been normalized, `validate(_:)` throws
  ``DKMValidator/Error/notNormalized``.
- If any issues are found, the returned score is the **input unchanged** (its
  `isValidated` flag stays `false`). Fix the issues — or run it through the
  normalizer again after editing — and validate again.
- Only when the issues array is empty does the returned score have
  `isValidated == true` — the prerequisite for formatting.

Every ``DKMValidator/Issue`` case names a value the reference implementation
cannot recover from silently: it either invents a replacement with a warning,
or halts outright. This includes a beat beyond the reference’s fixed
`8192`-entry tempo table, a `` `/GEQ` `` line with the wrong band-gain count, a
non-finite or out-of-range parameter, a non-positive duration or tempo, an
unwritable name, an incomplete graphic EQ segment, and a clip or vocode note
with no preceding mode command. Instrument and clip *names* are notably
**not** checked for existence — the reference implementation resolves those
against an external instrument file and clip list file, and this package does
no file I/O, so it cannot know whether a name is valid.

## Formatting

``DKMFormatter`` serializes a **validated** score back to binary data:

```swift
let data = try DKMFormatter().format(validated)
```

If the score has not been validated, `format(_:)` throws
``DKMFormatter/Error/notValidated``. Because the model is validated first,
formatting itself only fails on a string argument containing characters the
JohnnySonic format cannot represent.

### The round-trip contract

Round-tripping through `parse → format` is **AST-stable, not byte-stable**, in
two independent ways:

1. **Section spelling.** The parser recognizes a section by the first three
   characters of its name; the formatter always emits the canonical spelling
   (`` `/ScreenOut` ``, never `` `/ScreenOutput` ``). A score written with the
   reference implementation’s own real-world spellings re-parses to the same
   ``DKMCommand``, but the formatted bytes differ from the input.
2. **Number formatting.** A value written as `60` parses to `60.0` and prints
   back as `"60.0"`. So `format(parse(x)) != x` at the byte level in general —
   but the pipeline is idempotent from the second generation onward:
   `format(parse(format(parse(x)))) == format(parse(x))`.

The contract to rely on, and the one this package’s own round-trip tests
assert, is: `parse → format → parse` produces a ``DKMScore`` equal to the one
you started with, and formatting that result a second time is byte-identical
to the first. Never assert byte equality against the original input.

## The AST model

The syntactic model is a flat list of commands:

```
DKMScore
└─ commands: [DKMCommand]   // .chorusLine | .clipMode | .clipNote | … | .vocodeNote
```

``DKMCommand`` is an enum with one case per JohnnySonic section or note type;
a case whose section carries more than one line-worth of parameters wraps them
in a dedicated payload type (``DKMChorusLine``, ``DKMPitchesNote``, and so on).
Command order is meaningful: settings and mode commands are sticky, applying
to every subsequent command until overridden, and section headers compress a
maximal run of same-kind lines — this is why ``DKMNormalizer`` never reorders
commands.

``DKMScore`` equality and hashing compare `commands` only; `isNormalized` and
`isValidated` are pipeline metadata and are excluded.

## Building a score programmatically

You can construct the AST directly rather than parsing bytes:

```swift
let note = DKMPitchesNote(startBeat: 0.0,
                          duration: 4.0,
                          volume: 1.0,
                          location: 0.0,
                          startPitch: 60.0,
                          endPitch: 60.0,
                          instrument: "Piano")

let score = DKMScore(commands: [.soundFileName("Data/Output.AIFF"),
                                .pitchesNote(note),
                                .end])
```

A directly-constructed score has `isNormalized == false` and `isValidated ==
false` — exactly like one fresh out of the parser — so it must be run through
the normalizer and validator before formatting.

## Error handling

Thrown errors conform to `EnhancedError` (from
[XestiTools](https://github.com/eBardX/XestiTools)): each has a `category` of
`"IvorJohnnySonic"` and a human-readable `message`.

 Type                    | Thrown by
:----                    |:---------
 ``DKMParser/Error``     | `DKMParser.parse(_:)`
 ``DKMValidator/Error``  | `DKMValidator.validate(_:)`
 ``DKMFormatter/Error``  | `DKMFormatter.format(_:)`

Non-fatal results are returned rather than thrown, and each also provides a
`message`:

 Type                       | Returned by     | Also
:----                       |:-----------     |:-----
 ``DKMParser/Diagnostic``   | `parse(_:)`     | —
 ``DKMNormalizer/Change``   | `normalize(_:)` | `commandIndex` (`Int?`)
 ``DKMValidator/Issue``     | `validate(_:)`  | `commandIndex` (`Int?`)

## Concurrency

IvorJohnnySonic is built for Swift 6 strict concurrency. Every public type —
the four processing types and the entire AST — is a `Sendable` value type, so
instances can be freely shared across tasks and actor boundaries. The
processing types hold no mutable state, so a single ``DKMParser``,
``DKMNormalizer``, ``DKMValidator``, or ``DKMFormatter`` instance can be
reused for any number of concurrent operations.
