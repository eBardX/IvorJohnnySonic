// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMParser {

    // MARK: Public Nested Types

    /// A diagnostic message produced by ``DKMParser`` describing a recovery it
    /// performed while parsing.
    public enum Diagnostic {

        /// A `/GEQ` line carried a band-gain count other than the 30 the
        /// reference implementation’s graphic equalizer defines.
        ///
        /// The associated values are the line number and the actual band-gain
        /// count.
        case bandGainCountMismatch(lineNumber: Int, count: Int)

        /// An integer-valued parameter was written with a fractional part; it
        /// was truncated toward zero, matching the reference implementation’s
        /// `(int)` cast of a `%lf` read.
        ///
        /// The associated values are the line number, the parameter name, and
        /// the value as parsed before truncation.
        case truncatedIntegerParameter(lineNumber: Int, parameter: String, value: Double)
    }
}

// MARK: -

extension DKMParser.Diagnostic {

    // MARK: Public Instance Properties

    /// A human-readable description of this diagnostic.
    public var message: String {
        switch self {
        case let .bandGainCountMismatch(lineNumber, count):
            "‘/GEQ’ line \(lineNumber) declared \(count) band gain(s); expected 30"

        case let .truncatedIntegerParameter(lineNumber, parameter, value):
            "Parameter ‘\(parameter)’ on line \(lineNumber) truncated from \(value) to \(Int(value))"
        }
    }
}

// MARK: - Equatable

extension DKMParser.Diagnostic: Equatable {
}

// MARK: - Hashable

extension DKMParser.Diagnostic: Hashable {
}

// MARK: - Sendable

extension DKMParser.Diagnostic: Sendable {
}
