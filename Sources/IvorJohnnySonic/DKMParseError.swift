// © 2026 John Gary Pusey (see LICENSE.md)

public import XestiTools

/// An error that occurs when parsing JohnnySonic score data.
public enum DKMParseError {

    /// The input data could not be decoded as a UTF-8 string.
    case dataConversionFailed

    /// A data line has the wrong number of parameters.
    ///
    /// The associated values are the line number, the expected parameter count,
    /// and the actual parameter count.
    case invalidParameterCount(Int, Int, Int)

    /// A parameter on a data line has an invalid value.
    ///
    /// The associated values are the line number, the parameter name, and the
    /// invalid parameter string.
    case invalidParameterValue(Int, String, Substring)

    /// A section name is not recognized.
    ///
    /// The associated values are the line number and the unrecognized name.
    case invalidSection(Int, String)

    /// A data line appears before any section has been established.
    ///
    /// The associated value is the line number.
    case unexpectedDataLine(Int)
}

// MARK: - EnhancedError

extension DKMParseError: EnhancedError {

    /// The error category identifying the source module.
    public var category: Category? {
        Category("IvorJohnnySonic")
    }

    /// A human-readable description of this error.
    public var message: String {
        switch self {
        case .dataConversionFailed:
            "Failed to convert data to UTF-8 string"

        case let .invalidParameterCount(lineNumber, expected, actual):
            "Invalid parameter count on line \(lineNumber): expected \(expected), actual \(actual)"

        case let .invalidParameterValue(lineNumber, parameter, value):
            "Invalid value for parameter ‘\(parameter)’ on line \(lineNumber): ‘\(value)’"

        case let .invalidSection(lineNumber, name):
            "Invalid section name on line \(lineNumber): ‘/\(name)’"

        case let .unexpectedDataLine(lineNumber):
            "Unexpected data line \(lineNumber): no current section"
        }
    }
}

// MARK: - Sendable

extension DKMParseError: Sendable {
}
