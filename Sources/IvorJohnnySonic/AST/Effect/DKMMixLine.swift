// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for mixing the sound and Haas buffers into the mix
/// buffer.
///
/// A negative start beat is clamped to zero by the reference implementation
/// (`ProcessMix`), and by ``DKMNormalizer``.
public struct DKMMixLine {

    // MARK: Public Initializers

    /// Creates a new mix line.
    ///
    /// - Parameter startBeat:       Starting beat; a negative value is clamped
    ///                              to zero.
    /// - Parameter duration:        Duration in beats.
    /// - Parameter gainLossdB:      Gain/loss in dB.
    /// - Parameter keepSoundBuffer: `true` to retain the sound and Haas
    ///                              buffers; `false` to clear them after
    ///                              mixing.
    /// - Parameter sign:            Sign factor; use `–1` to invert.
    /// - Parameter timeOffset:      Time offset in seconds (can be positive or
    ///                              negative).
    public init(startBeat: Double,
                duration: Double,
                gainLossdB: Double,
                keepSoundBuffer: Bool,
                sign: Double,
                timeOffset: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.gainLossdB = gainLossdB
        self.keepSoundBuffer = keepSoundBuffer
        self.sign = sign
        self.timeOffset = timeOffset
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Gain/loss in dB.
    public let gainLossdB: Double

    /// `true` to retain the sound and Haas buffers; `false` to clear them
    /// after mixing.
    public let keepSoundBuffer: Bool

    /// Sign factor; use `–1` to invert.
    public let sign: Double

    /// Starting beat; a negative value is clamped to zero.
    public let startBeat: Double

    /// Time offset in seconds (can be positive or negative).
    public let timeOffset: Double
}

// MARK: - Equatable

extension DKMMixLine: Equatable {
}

// MARK: - Hashable

extension DKMMixLine: Hashable {
}

// MARK: - Sendable

extension DKMMixLine: Sendable {
}
