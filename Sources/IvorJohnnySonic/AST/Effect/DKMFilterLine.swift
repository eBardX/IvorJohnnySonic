// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for applying an audio filter to a segment of the
/// sound buffer.
///
/// A negative start beat is clamped to zero by the reference implementation
/// (`ProcessFilter`), and by ``DKMNormalizer``.
public struct DKMFilterLine {

    // MARK: Public Initializers

    /// Creates a new filter line.
    ///
    /// - Parameter startBeat:          Starting beat; a negative value is
    ///                                 clamped to zero.
    /// - Parameter duration:           Duration in beats.
    /// - Parameter filterType:         The filter type.
    /// - Parameter initialPitch:       Initial pitch (positive = pitch number;
    ///                                 negative = frequency in Hz).
    /// - Parameter finalPitch:         Final pitch (positive = pitch number;
    ///                                 negative = frequency in Hz).
    /// - Parameter initialBandwidth:   Initial bandwidth (positive = semitones;
    ///                                 negative = Hz); applies to types 1, 2, 5, 6 only.
    /// - Parameter finalBandwidth:     Final bandwidth (positive = semitones;
    ///                                 negative = Hz); applies to types 1, 2, 5, 6 only.
    public init(startBeat: Double,
                duration: Double,
                filterType: DKMFilterType,
                initialPitch: Double,
                finalPitch: Double,
                initialBandwidth: Double,
                finalBandwidth: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.filterType = filterType
        self.initialPitch = initialPitch
        self.finalPitch = finalPitch
        self.initialBandwidth = initialBandwidth
        self.finalBandwidth = finalBandwidth
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// The filter type.
    public let filterType: DKMFilterType

    /// Final bandwidth (positive = semitones; negative = Hz); applies to
    /// types 1, 2, 5, 6 only.
    public let finalBandwidth: Double

    /// Final pitch (positive = pitch number; negative = frequency in Hz).
    public let finalPitch: Double

    /// Initial bandwidth (positive = semitones; negative = Hz); applies to
    /// types 1, 2, 5, 6 only.
    public let initialBandwidth: Double

    /// Initial pitch (positive = pitch number; negative = frequency in Hz).
    public let initialPitch: Double

    /// Starting beat; a negative value is clamped to zero.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMFilterLine: Equatable {
}

// MARK: - Hashable

extension DKMFilterLine: Hashable {
}

// MARK: - Sendable

extension DKMFilterLine: Sendable {
}
