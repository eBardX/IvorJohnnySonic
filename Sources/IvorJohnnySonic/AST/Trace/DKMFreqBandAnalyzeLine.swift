// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for a frequency band analysis.
public struct DKMFreqBandAnalyzeLine {

    // MARK: Public Initializers

    /// Creates a new frequency band analysis line.
    ///
    /// - Parameter startBeat: Starting beat for the analysis.
    /// - Parameter duration:  Duration in beats.
    /// - Parameter channel:   The channel to analyze.
    /// - Parameter buffer:    The buffer to analyze.
    public init(startBeat: Double,
                duration: Double,
                channel: DKMFBAChannel,
                buffer: DKMFBABuffer) {
        self.startBeat = startBeat
        self.duration = duration
        self.channel = channel
        self.buffer = buffer
    }

    // MARK: Public Instance Properties

    /// The buffer to analyze.
    public let buffer: DKMFBABuffer

    /// The channel to analyze.
    public let channel: DKMFBAChannel

    /// Duration in beats.
    public let duration: Double

    /// Starting beat for the analysis.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMFreqBandAnalyzeLine: Equatable {
}

// MARK: - Hashable

extension DKMFreqBandAnalyzeLine: Hashable {
}

// MARK: - Sendable

extension DKMFreqBandAnalyzeLine: Sendable {
}
