// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for sending a segment of the mix buffer back to the
/// sound buffer.
///
/// The sound buffer is overwritten at the specified segment, and that
/// segment of the mix buffer is cleared.
public struct DKMSendBackLine {

    // MARK: Public Initializers

    /// Creates a new send-back line.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter gainLossdB: Gain/loss in dB.
    public init(startBeat: Double,
                duration: Double,
                gainLossdB: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.gainLossdB = gainLossdB
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Gain/loss in dB.
    public let gainLossdB: Double

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMSendBackLine: Equatable {
}

// MARK: - Hashable

extension DKMSendBackLine: Hashable {
}

// MARK: - Sendable

extension DKMSendBackLine: Sendable {
}
