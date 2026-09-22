# IvorJohnnySonic

A JohnnySonic score file parser, normalizer, validator, and formatter.

[![Swift 6.3](https://img.shields.io/badge/Swift-6.3-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/eBardX/IvorJohnnySonic/blob/main/LICENSE.md)

* [Overview](#overview)
* [Requirements](#requirements)
* [Installation](#installation)
    * [Swift Package Manager](#spm_installation)
* [Quick Start](#quick_start)
* [Documentation](#documentation)
* [Reference Documentation](#reference_documentation)
* [Credits](#credits)
* [License](#license)

## <a name="overview">Overview</a>

The IvorJohnnySonic framework provides a [JohnnySonic score file][johnnysonic]
parser and formatter written in Swift, with a strict-concurrency-ready,
value-type API.

Everything flows through a small, explicit pipeline of four value types, each
with a no-argument initializer:

 Stage     | Type            | Input → Output
:-----     |:----            |:--------------
 Parse     | `DKMParser`     | `Data` → `DKMScore`
 Normalize | `DKMNormalizer` | `DKMScore` → `DKMScore` (canonical)
 Validate  | `DKMValidator`  | `DKMScore` → validated `DKMScore`
 Format    | `DKMFormatter`  | `DKMScore` → `Data`

The pipeline is gated by two flags on `DKMScore`: a score must be normalized
before it can be validated, and validated before it can be formatted. See the
[usage guide][guide] for a full walkthrough of the API.

## <a name="requirements">Requirements</a>

* iOS 18.0+ / macOS 15.0+
* Swift 6.3 toolchain
* Swift 6 language mode

## <a name="installation">Installation</a>

### <a name="spm_installation">Swift Package Manager</a>

IvorJohnnySonic is distributed exclusively through the [Swift Package
Manager][spm].

To add IvorJohnnySonic to a Swift package, add it to the `dependencies` in
your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/eBardX/IvorJohnnySonic.git",
             .upToNextMajor(from: "3.0.0"))
]
```

Then add `IvorJohnnySonic` to the dependencies of any target that uses it:

```swift
.target(name: "MyTarget",
        dependencies: [.product(name: "IvorJohnnySonic",
                                package: "IvorJohnnySonic")])
```

To add IvorJohnnySonic to an Xcode project, choose **File ▸ Add Package
Dependencies…** and enter the repository URL:

```
https://github.com/eBardX/IvorJohnnySonic.git
```

IvorJohnnySonic depends on [XestiTools][xestitools]; the Swift Package Manager
resolves it automatically.

## <a name="quick_start">Quick Start</a>

Take a JohnnySonic score file from `Data` all the way through validation:

```swift
import Foundation
import IvorJohnnySonic

let data = try Data(contentsOf: url)

// 1. Parse raw bytes into a typed score. Two specific, provably-safe
//    deviations are repaired and reported as diagnostics rather than thrown.
let (parsed, diagnostics) = try DKMParser().parse(data)

// 2. Normalize to canonical form (clamped beats/durations, resolved
//    continuations, no redundant settings).
let (normalized, changes) = DKMNormalizer().normalize(parsed)

// 3. Validate against the reference implementation's parameter constraints.
let (validated, issues) = try DKMValidator().validate(normalized)

guard issues.isEmpty
else { issues.forEach { print($0.message) }; return }

// 4. Format back to binary data.
let output = try DKMFormatter().format(validated)
```

Each stage is independent, so you can stop at the AST or round-trip through
the formatter. For the complete story — the AST model and error handling —
see the [usage guide][guide].

## <a name="documentation">Documentation</a>

* [Using IvorJohnnySonic][guide] — a guide to using the public API, published
  as part of the DocC documentation.
* Every public declaration carries a DocC comment; several call out the
  reference implementation's `main.c` — the format's semantic authority —
  where a clamp, recovery, or other behavior needs justification beyond the
  format's own documentation.

## <a name="reference_documentation">Reference Documentation</a>

Full [reference documentation][refdoc] is available courtesy of [DocC][docc].

## <a name="credits">Credits</a>

John Gary Pusey (ebardx@gmail.com)

## <a name="license">License</a>

IvorJohnnySonic is available under [the MIT license][license].

[docc]:         https://www.swift.org/documentation/docc/
[guide]:        https://eBardX.github.io/ivor-packages-docs/documentation/ivorjohnnysonic/usingivorjohnnysonic
[johnnysonic]:  https://github.com/JohnnySonic/JohnnySonic/blob/main/JohnnySonicDoc.pdf
[license]:      https://github.com/eBardX/IvorJohnnySonic/blob/main/LICENSE.md
[refdoc]:       https://eBardX.github.io/ivor-packages-docs/documentation/ivorjohnnysonic
[spm]:          https://swift.org/package-manager/
[xestitools]:   https://github.com/eBardX/XestiTools
