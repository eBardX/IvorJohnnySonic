// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import XestiTools

/// An error that occurs when formatting a JohnnySonic score.
public enum DKMFormatError {
    /// A string argument contains characters that are not valid in the
    /// JohnnySonic format.
    case invalidStringArgument(String)

    /// A string argument could not be converted to UTF-8 data.
    case stringConversionFailed
}

// MARK: - EnhancedError

extension DKMFormatError: EnhancedError {
    /// The error category identifying the source module.
    public var category: Category? {
        Category("IvorJohnnySonic")
    }

    /// A human-readable description of this error.
    public var message: String {
        switch self {
        case let .invalidStringArgument(value):
            "String argument contains invalid characters: \(value)"

        case .stringConversionFailed:
            "Failed to convert string to UTF-8 data"
        }
    }
}

// MARK: - Sendable

extension DKMFormatError: Sendable {
}
