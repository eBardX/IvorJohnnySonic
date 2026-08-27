// © 2026 John Gary Pusey (see LICENSE.md)

public import XestiTools

extension DKMValidator {

    // MARK: Public Nested Types

    /// An error thrown when a score operation requires prior normalization.
    public enum Error {

        /// ``DKMValidator/validate(_:)`` was called on a score whose
        /// ``DKMScore/isNormalized`` flag is `false`.
        ///
        /// Call ``DKMNormalizer/normalize(_:)`` before
        /// ``DKMValidator/validate(_:)``.
        case notNormalized
    }
}

// MARK: - EnhancedError

extension DKMValidator.Error: EnhancedError {

    /// The error category identifying the source module.
    public var category: Category? {
        Category("IvorJohnnySonic")
    }

    /// A human-readable description of this error.
    public var message: String {
        switch self {
        case .notNormalized:
            "Score must be normalized before validation; call DKMNormalizer.normalize(_:) first"
        }
    }
}

// MARK: - Equatable

extension DKMValidator.Error: Equatable {
}

// MARK: - Sendable

extension DKMValidator.Error: Sendable {
}
