// © 2026 John Gary Pusey (see LICENSE.md)

/// A room size for JohnnySonic reverb.
public enum DKMReverbSize: Int {
    /// Large room (40–71 ms).
    case large = 3

    /// Medium room (23–40 ms).
    case medium = 2

    /// Small room (13–23 ms).
    case small = 1
}

// MARK: - Sendable

extension DKMReverbSize: Sendable {
}
