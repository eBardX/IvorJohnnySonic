// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for invoking the choruser on a segment of the sound
/// buffer.
public struct DKMChorusLine {

    // MARK: Public Initializers

    /// Creates a new chorus line.
    ///
    /// - Parameter startBeat:      Starting beat.
    /// - Parameter duration:       Duration in beats.
    /// - Parameter numberOfVoices: Number of voices (typically even, voices are
    ///                             divided across channels).
    /// - Parameter depth:          Comb filter gain (must be less than 1).
    /// - Parameter flipChannels:   When `true`, the chorussed right channel is
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

    /// When `true`, the chorussed right channel is output to the left channel
    /// and vice versa.
    public let flipChannels: Bool

    /// Number of voices (typically even, voices are divided across channels).
    public let numberOfVoices: Int

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMChorusLine: Equatable {
}

// MARK: - Hashable

extension DKMChorusLine: Hashable {
}

// MARK: - Sendable

extension DKMChorusLine: Sendable {
}
