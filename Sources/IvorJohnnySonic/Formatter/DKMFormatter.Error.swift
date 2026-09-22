// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import XestiTools

extension DKMFormatter {

    // MARK: Public Nested Types

    /// An error that occurs when formatting a JohnnySonic score.
    public enum Error {

        /// A string argument contains characters that are not valid in the
        /// JohnnySonic format.
        case invalidStringArgument(String)

        /// ``DKMFormatter/format(_:)`` was called on a score whose
        /// ``DKMScore/isValidated`` flag is `false`.
        ///
        /// Call ``DKMValidator/validate(_:)`` before
        /// ``DKMFormatter/format(_:)``.
        case notValidated

        /// A string argument could not be converted to UTF-8 data.
        case stringConversionFailed
    }
}

// MARK: - EnhancedError

extension DKMFormatter.Error: EnhancedError {

    /// The error category identifying the source module.
    public var category: Category? {
        Category("IvorJohnnySonic")
    }

    /// A human-readable description of this error.
    public var message: String {
        switch self {
        case let .invalidStringArgument(value):
            "String argument contains invalid characters: \(value)"

        case .notValidated:
            "Score must be validated before formatting; call DKMValidator.validate(_:) first"

        case .stringConversionFailed:
            "Failed to convert string to UTF-8 data"
        }
    }
}

// MARK: - Equatable

extension DKMFormatter.Error: Equatable {
}

// MARK: - Sendable

extension DKMFormatter.Error: Sendable {
}
