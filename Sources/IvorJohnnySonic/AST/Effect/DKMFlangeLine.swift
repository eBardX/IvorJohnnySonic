// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for invoking the flanger on a segment of the sound
/// buffer.
public struct DKMFlangeLine {

    // MARK: Public Initializers

    /// Creates a new flange line.
    ///
    /// - Parameter startBeat:      Starting beat.
    /// - Parameter duration:       Duration in beats.
    /// - Parameter numberOfVoices: Number of voices (typically even, voices are
    ///                             divided across channels).
    /// - Parameter depth:          Comb filter gain (must be less than 1).
    /// - Parameter flipChannels:   When `true`, the flanged right channel is
    ///                             output to the left channel and vice versa.
    public init(startBeat: Double,
                duration: Double,
                numberOfVoices: Int,
                depth: Double,
                flipChannels: Bool) {
        self.startBeat = startBeat
        self.duration = duration
        self.numberOfVoices = numberOfVoices
        self.depth = depth
        self.flipChannels = flipChannels
    }

    // MARK: Public Instance Properties

    /// Comb filter gain (must be less than 1).
    public let depth: Double

    /// Duration in beats.
    public let duration: Double

    /// When `true`, the flanged right channel is output to the left channel
    /// and vice versa.
    public let flipChannels: Bool

    /// Number of voices (typically even, voices are divided across channels).
    public let numberOfVoices: Int

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMFlangeLine: Equatable {
}

// MARK: - Hashable

extension DKMFlangeLine: Hashable {
}

// MARK: - Sendable

extension DKMFlangeLine: Sendable {
}
