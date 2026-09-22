// © 2026 John Gary Pusey (see LICENSE.md)

/// A channel selection for a frequency band analysis.
public enum DKMFBAChannel: Int {
    /// Both channels combined.
    case combined = -1

    /// The left channel.
    case left = 0

    /// The right channel.
    case right = 1
}

// MARK: - Sendable

extension DKMFBAChannel: Sendable {
}
