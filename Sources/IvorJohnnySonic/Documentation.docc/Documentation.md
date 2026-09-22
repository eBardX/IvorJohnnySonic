# ``IvorJohnnySonic``

@Metadata {
    @PageColor(blue)
}

A JohnnySonic score file parser and formatter.

## Overview

The IvorJohnnySonic framework provides a [JohnnySonic score
file](https://github.com/JohnnySonic/JohnnySonic/blob/main/JohnnySonicDoc.pdf)
parser and formatter written in Swift, with a strict-concurrency-ready,
value-type API.

### The pipeline

Everything flows through a small, explicit pipeline of four value types, each a
`Sendable` value type with a no-argument initializer:

 Stage     | Type               | Input → Output
:-----     |:----               |:--------------
 Parse     | ``DKMParser``      | `Data` → ``DKMScore``
 Normalize | ``DKMNormalizer``  | ``DKMScore`` → ``DKMScore`` (canonical)
 Validate  | ``DKMValidator``   | ``DKMScore`` → validated ``DKMScore``
 Format    | ``DKMFormatter``   | ``DKMScore`` → `Data`

A ``DKMScore`` carries two Boolean state flags that enforce the order of the
pipeline: a score must be normalized before it can be validated, and validated
before it can be formatted. Both normalization and validation are idempotent,
so it is always safe to run the full pipeline:

```swift
import Foundation
import IvorJohnnySonic

let data = try Data(contentsOf: url)

let (parsed, diagnostics) = try DKMParser().parse(data)
let (normalized, changes) = DKMNormalizer().normalize(parsed)
let (validated, issues)   = try DKMValidator().validate(normalized)

guard issues.isEmpty else {
    issues.forEach { print($0.message) }
    return
}

let output = try DKMFormatter().format(validated)  // back to JohnnySonic
```

See <doc:UsingIvorJohnnySonic> for a full guide to each stage, the models,
and error handling.

## Topics

### Guides

- <doc:UsingIvorJohnnySonic>

### Processing

- ``DKMParser``
- ``DKMNormalizer``
- ``DKMValidator``
- ``DKMFormatter``

### Score model

- ``DKMScore``
- ``DKMCommand``

### Effects

- ``DKMChorusLine``
- ``DKMCompressLine``
- ``DKMFilterLine``
- ``DKMFilterType``
- ``DKMFlangeLine``
- ``DKMGEQLine``
- ``DKMLevelsLine``
- ``DKMMixLine``
- ``DKMReverbDirection``
- ``DKMReverbLine``
- ``DKMReverbSize``
- ``DKMSendBackLine``

### Notes

- ``DKMClipChannel``
- ``DKMClipMode``
- ``DKMClipNote``
- ``DKMPitchesNote``
- ``DKMVocodeMode``
- ``DKMVocodeNote``

### Settings

- ``DKMChannel``
- ``DKMHaas``
- ``DKMPulseLine``
- ``DKMScreenLevel``
- ``DKMTempoLine``
- ``DKMTuning``

### Analysis

- ``DKMFBABuffer``
- ``DKMFBAChannel``
- ``DKMFreqBandAnalyzeLine``
- ``DKMShowBufferLine``
- ``DKMStatsLine``
