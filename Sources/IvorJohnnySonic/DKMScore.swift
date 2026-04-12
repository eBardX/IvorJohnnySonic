// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A Johnny Sonic score consisting of an ordered list of entries.
public struct DKMScore {

    // MARK: Public Initializers

    /// Creates a new Johnny Sonic score with the provided entries.
    ///
    /// - Parameter entries:    The entries in the score.
    public init(entries: [DKMEntry]) {
        self.entries = entries
    }

    // MARK: Public Instance Properties

    /// The entries in the score.
    public let entries: [DKMEntry]
}

// MARK: - Sendable

extension DKMScore: Sendable {
}
