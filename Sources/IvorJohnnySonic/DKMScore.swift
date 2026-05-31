// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A JohnnySonic score consisting of an ordered list of commands.
public struct DKMScore {

    // MARK: Public Initializers

    /// Creates a new JohnnySonic score with the provided commands.
    ///
    /// - Parameter commands:   The commands in the score.
    public init(commands: [DKMCommand]) {
        self.commands = commands
    }

    // MARK: Public Instance Properties

    /// The commands in the score.
    public let commands: [DKMCommand]
}

// MARK: - Sendable

extension DKMScore: Sendable {
}
