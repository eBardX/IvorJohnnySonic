// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for adjusting levels on a segment of the sound
/// buffer.
///
/// Pass `–1` for `startBeat` to continue from where the previous levels line
/// left off.
public struct DKMLevelsLine {

    // MARK: Public Initializers

    /// Creates a new levels line.
    ///
    /// - Parameter startBeat:       Starting beat (–1 to continue).
    /// - Parameter duration:        Duration in beats.
    /// - Parameter startGainLossdB: Initial gain/loss in dB.
    /// - Parameter endGainLossdB:   Final gain/loss in dB.
    public init(startBeat: Double,
                duration: Double,
                startGainLossdB: Double,
                endGainLossdB: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.startGainLossdB = startGainLossdB
        self.endGainLossdB = endGainLossdB
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Final gain/loss in dB.
    public let endGainLossdB: Double

    /// Starting beat (–1 to continue).
    public let startBeat: Double

    /// Initial gain/loss in dB.
    public let startGainLossdB: Double
}

// MARK: - Equatable

extension DKMLevelsLine: Equatable {
}

// MARK: - Hashable

extension DKMLevelsLine: Hashable {
}

// MARK: - Sendable

extension DKMLevelsLine: Sendable {
}
