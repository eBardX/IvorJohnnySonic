// © 2026 John Gary Pusey (see LICENSE.md)

/// A type that validates a JohnnySonic score against the reference
/// implementation’s parameter constraints.
public struct DKMValidator {

    // MARK: Public Initializers

    /// Creates a new JohnnySonic validator.
    public init() {
    }
}

// MARK: -

extension DKMValidator {

    // MARK: Public Instance Methods

    /// Validates the provided score against the reference implementation’s
    /// parameter constraints and returns any issues found.
    ///
    /// Every remaining ``Issue`` case indicates a value the reference
    /// implementation cannot recover from silently — it either invents a
    /// replacement value with `MyWarn`, or halts with `myError`. Deviations
    /// the reference *does* recover from silently (a negative start beat, a
    /// `` `/Levels` `` continuation) are instead fixed automatically by
    /// ``DKMNormalizer``, which must run before this method.
    ///
    /// - Parameter score:   The score to validate.
    ///
    /// - Returns:  A tuple of the validated score and an array of ``Issue``
    ///             values. The score in the tuple is a copy of `score` with
    ///             ``DKMScore/isValidated`` set to `true` when no issues are
    ///             found; otherwise `score` is returned unchanged
    ///             (re-validating after fixing issues is required). An empty
    ///             issues array means the score is fully conformant.
    ///
    /// - Throws:   ``Error/notNormalized`` if ``DKMScore/isNormalized`` is
    ///             `false`. Call ``DKMNormalizer/normalize(_:)`` before
    ///             calling this method.
    public func validate(_ score: DKMScore) throws(DKMValidator.Error) -> (DKMScore, [Issue]) {
        guard !score.isValidated
        else { return (score, []) }

        guard score.isNormalized
        else { throw Error.notNormalized }

        var checker = Checker(score: score)

        let issues = checker.checkScore()

        guard issues.isEmpty
        else { return (score, issues) }

        return (DKMScore(commands: score.commands,
                         isNormalized: score.isNormalized,
                         isValidated: true), [])
    }
}

// MARK: - Sendable

extension DKMValidator: Sendable {
}
