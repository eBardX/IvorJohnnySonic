// © 2026 John Gary Pusey (see LICENSE.md)

/// A screen output level for JohnnySonic.
public enum DKMScreenLevel: Int {
    /// Debug output.
    case debug = 3

    /// Medium output.
    case medium = 1

    /// Quiet output.
    case quiet = 0

    /// Verbose output.
    case verbose = 2
}

// MARK: - Sendable

extension DKMScreenLevel: Sendable {
}
