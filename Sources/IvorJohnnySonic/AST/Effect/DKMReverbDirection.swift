// © 2026 John Gary Pusey (see LICENSE.md)

/// A direction for JohnnySonic reverb.
public enum DKMReverbDirection: Int {
    /// Backward reverb (pre-verb).
    case backward = -1

    /// Forward reverb.
    case forward = 1
}

// MARK: - Sendable

extension DKMReverbDirection: Sendable {
}
