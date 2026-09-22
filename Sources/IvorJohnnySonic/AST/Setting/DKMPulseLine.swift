// © 2026 John Gary Pusey (see LICENSE.md)

/// A one-sample pulse inserted into the sound buffer.
///
/// Useful for testing processors such as reverb and filters.
public struct DKMPulseLine {

    // MARK: Public Initializers

    /// Creates a new pulse line.
    ///
    /// - Parameter startBeat: Starting beat.
    /// - Parameter channel:   The channel to receive the pulse.
    public init(startBeat: Double,
                channel: DKMChannel) {
        self.startBeat = startBeat
        self.channel = channel
    }

    // MARK: Public Instance Properties

    /// The channel to receive the pulse.
    public let channel: DKMChannel

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMPulseLine: Equatable {
}

// MARK: - Hashable

extension DKMPulseLine: Hashable {
}

// MARK: - Sendable

extension DKMPulseLine: Sendable {
}
