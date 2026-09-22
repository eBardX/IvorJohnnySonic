// © 2026 John Gary Pusey (see LICENSE.md)

/// A channel selection for clip and vocode modes.
public enum DKMClipChannel: Int {
    /// The left channel.
    case left = 0

    /// The right channel.
    case right = 1
}

// MARK: - Sendable

extension DKMClipChannel: Sendable {
}
