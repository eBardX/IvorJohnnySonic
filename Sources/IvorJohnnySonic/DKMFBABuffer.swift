// © 2026 John Gary Pusey (see LICENSE.md)

/// A buffer selection for a frequency band analysis.
public enum DKMFBABuffer: String {
    /// The mix buffer.
    case mix = "M"

    /// The sound buffer.
    case sound = "S"
}

// MARK: - Sendable

extension DKMFBABuffer: Sendable {
}
