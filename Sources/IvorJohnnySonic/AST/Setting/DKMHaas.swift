// © 2026 John Gary Pusey (see LICENSE.md)

/// A command that sets the global Haas effect parameters.
///
/// Affects all subsequent notes until changed by another ``DKMHaas``
/// command. Haas is disabled by default.
public struct DKMHaas {

    // MARK: Public Initializers

    /// Creates a new Haas command.
    ///
    /// - Parameter enabled:    `true` to enable the Haas effect.
    /// - Parameter minDelay:   Minimum delay in milliseconds (0–40).
    /// - Parameter maxDelay:   Maximum delay in milliseconds (0–90).
    /// - Parameter reverbSend: `true` to send to reverb.
    public init(enabled: Bool,
                minDelay: Double,
                maxDelay: Double,
                reverbSend: Bool) {
        self.enabled = enabled
        self.minDelay = minDelay
        self.maxDelay = maxDelay
        self.reverbSend = reverbSend
    }

    // MARK: Public Instance Properties

    /// `true` to enable the Haas effect.
    public let enabled: Bool

    /// Maximum delay in milliseconds (0–90).
    public let maxDelay: Double

    /// Minimum delay in milliseconds (0–40).
    public let minDelay: Double

    /// `true` to send to reverb.
    public let reverbSend: Bool
}

// MARK: - Equatable

extension DKMHaas: Equatable {
}

// MARK: - Hashable

extension DKMHaas: Hashable {
}

// MARK: - Sendable

extension DKMHaas: Sendable {
}
