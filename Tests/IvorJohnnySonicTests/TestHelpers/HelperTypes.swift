// © 2026 John Gary Pusey (see LICENSE.md)

import IvorJohnnySonic

// Thrown by `formatScore(_:)` when a test fixture unexpectedly fails
// validation, so the failure surfaces at the call site rather than being
// silently swallowed.
internal struct UnexpectedValidationIssues {

    // MARK: Internal Instance Properties

    internal let issues: [DKMValidator.Issue]
}

// MARK: - CustomStringConvertible

extension UnexpectedValidationIssues: CustomStringConvertible {

    // MARK: Internal Instance Properties

    internal var description: String {
        "Score failed validation unexpectedly: " + issues.map(\.message).joined(separator: "; ")
    }
}

// MARK: - Error

extension UnexpectedValidationIssues: Error {
}
