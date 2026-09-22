// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

/// A type that formats a JohnnySonic score as binary data.
public struct DKMFormatter {

    // MARK: Public Initializers

    /// Creates a new JohnnySonic formatter.
    public init() {
    }
}

// MARK: -

extension DKMFormatter {

    // MARK: Public Instance Methods

    /// Formats the provided JohnnySonic score as binary data.
    ///
    /// - Parameter score:  The JohnnySonic score to format.
    ///
    /// - Returns:  The binary data representation of the score.
    ///
    /// - Throws:   ``Error/notValidated`` if ``DKMScore/isValidated`` is
    ///             `false`. Call ``DKMValidator/validate(_:)`` before calling
    ///             this method. Also throws ``DKMFormatter/Error`` if the
    ///             score cannot otherwise be formatted.
    public func format(_ score: DKMScore) throws(DKMFormatter.Error) -> Data {
        guard score.isValidated
        else { throw Error.notValidated }

        var writer = Writer(score: score)

        return try writer.writeScore()
    }
}

// MARK: - Sendable

extension DKMFormatter: Sendable {
}
