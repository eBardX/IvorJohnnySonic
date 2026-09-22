// © 2026 John Gary Pusey (see LICENSE.md)

/// A channel selection for a JohnnySonic pulse.
public enum DKMChannel: String {
    /// Both channels.
    case both = "B"

    /// The left channel.
    case left = "L"

    /// The right channel.
    case right = "R"
}

// MARK: - Sendable

extension DKMChannel: Sendable {
}
