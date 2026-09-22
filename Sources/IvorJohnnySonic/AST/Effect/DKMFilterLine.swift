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
    /// - Parameter startBeat:      Start beat; a negative value is
    ///                             clamped to zero.
    /// - Parameter duration:       Duration in beats.
    /// - Parameter filterType:     The filter type.
    /// - Parameter startPitch:     Start pitch (positive = pitch number;
    ///                             negative = frequency in Hz).
    /// - Parameter endPitch:       End pitch (positive = pitch number;
    ///                             negative = frequency in Hz).
    /// - Parameter startBandwidth: Start bandwidth (positive = semitones;
    ///                             negative = Hz); applies to types 1, 2, 5, 6 only.
    /// - Parameter endBandwidth:   End bandwidth (positive = semitones;
    ///                             negative = Hz); applies to types 1, 2, 5, 6 only.
    public init(startBeat: Double,
                duration: Double,
                filterType: DKMFilterType,
                startPitch: Double,
                endPitch: Double,
                startBandwidth: Double,
                endBandwidth: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.filterType = filterType
        self.startPitch = startPitch
        self.endPitch = endPitch
        self.startBandwidth = startBandwidth
        self.endBandwidth = endBandwidth
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// End bandwidth (positive = semitones; negative = Hz); applies to
    /// types 1, 2, 5, 6 only.
    public let endBandwidth: Double

    /// End pitch (positive = pitch number; negative = frequency in Hz).
    public let endPitch: Double

    /// The filter type.
    public let filterType: DKMFilterType

    /// Start bandwidth (positive = semitones; negative = Hz); applies to
    /// types 1, 2, 5, 6 only.
    public let startBandwidth: Double

    /// Start beat; a negative value is clamped to zero.
    public let startBeat: Double

    /// Start pitch (positive = pitch number; negative = frequency in Hz).
    public let startPitch: Double
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
