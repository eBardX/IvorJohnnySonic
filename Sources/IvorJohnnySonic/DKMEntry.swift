// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A single entry in a Johnny Sonic score, consisting of a command and its
/// arguments.
public struct DKMEntry {

    // MARK: Public Initializers

    /// Creates a new Johnny Sonic entry with the provided command and
    /// arguments.
    ///
    /// - Parameter command:    The Johnny Sonic command for the entry.
    /// - Parameter arguments:  The arguments to the command.
    public init(command: DKMCommand,
                arguments: DKMArgument...) {
        self.command = command
        self.arguments = arguments
    }

    // MARK: Public Instance Properties

    /// The Johnny Sonic command for this entry.
    public let command: DKMCommand

    /// The arguments to the command.
    public let arguments: [DKMArgument]
}

// MARK: - Sendable

extension DKMEntry: Sendable {
}
