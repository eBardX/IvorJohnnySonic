// © 2026 John Gary Pusey (see LICENSE.md)

/// A command that sets clip mode, specifying the clip channel and clip name.
///
/// Must precede any ``DKMClipNote`` entries for this clip.
public struct DKMClipMode {

    // MARK: Public Initializers

    /// Creates a new clip mode command.
    ///
    /// - Parameter channel: The clip channel.
    /// - Parameter name:    The clip name (must match an entry in the clip
    ///                      list file).
    public init(channel: DKMClipChannel,
                name: String) {
        self.channel = channel
        self.name = name
    }

    // MARK: Public Instance Properties

    /// The clip channel.
    public let channel: DKMClipChannel

    /// The clip name (must match an entry in the clip list file).
    public let name: String
}

// MARK: - Equatable

extension DKMClipMode: Equatable {
}

// MARK: - Hashable

extension DKMClipMode: Hashable {
}

// MARK: - Sendable

extension DKMClipMode: Sendable {
}
