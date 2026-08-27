// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for invoking the reverberator on a segment of the
/// sound buffer.
public struct DKMReverbLine {

    // MARK: Public Initializers

    /// Creates a new reverb line.
    ///
    /// - Parameter startBeat:         Starting beat.
    /// - Parameter duration:          Duration in beats.
    /// - Parameter direction:         Reverb direction.
    /// - Parameter size:              Room size.
    /// - Parameter reverbTime:        60 dB reverb time in seconds.
    /// - Parameter combFilterDryGain: Gain on the dry signal.
    /// - Parameter xTalkFactor:       Cross-channel gain factor (0–1).
    /// - Parameter wetness:           Mix of wet/dry on output (0–1).
    public init(startBeat: Double,
                duration: Double,
                direction: DKMReverbDirection,
                size: DKMReverbSize,
                reverbTime: Double,
                combFilterDryGain: Double,
                xTalkFactor: Double,
                wetness: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.direction = direction
        self.size = size
        self.reverbTime = reverbTime
        self.combFilterDryGain = combFilterDryGain
        self.xTalkFactor = xTalkFactor
        self.wetness = wetness
    }

    // MARK: Public Instance Properties

    /// Gain on the dry signal.
    public let combFilterDryGain: Double

    /// Reverb direction.
    public let direction: DKMReverbDirection

    /// Duration in beats.
    public let duration: Double

    /// 60 dB reverb time in seconds.
    public let reverbTime: Double

    /// Room size.
    public let size: DKMReverbSize

    /// Starting beat.
    public let startBeat: Double

    /// Mix of wet/dry on output (0–1).
    public let wetness: Double

    /// Cross-channel gain factor (0–1).
    public let xTalkFactor: Double
}

// MARK: - Equatable

extension DKMReverbLine: Equatable {
}

// MARK: - Hashable

extension DKMReverbLine: Hashable {
}

// MARK: - Sendable

extension DKMReverbLine: Sendable {
}
