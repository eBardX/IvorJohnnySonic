// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters defining the tempo or a tempo change.
///
/// If no ``DKMTempoLine`` is present, the default tempo of 60 BPM is used.
/// Changes use linear interpolation and occur on whole-number beats.
public struct DKMTempoLine {

    // MARK: Public Initializers

    /// Creates a new tempo line.
    ///
    /// - Parameter startBeat:    Starting beat for this tempo segment.
    /// - Parameter duration:     Duration of the tempo change in beats.
    /// - Parameter initialTempo: Initial tempo in beats per minute.
    /// - Parameter finalTempo:   Final tempo in beats per minute.
    public init(startBeat: Double,
                duration: Double,
                initialTempo: Double,
                finalTempo: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.initialTempo = initialTempo
        self.finalTempo = finalTempo
    }

    // MARK: Public Instance Properties

    /// Duration of the tempo change in beats.
    public let duration: Double

    /// Final tempo in beats per minute.
    public let finalTempo: Double

    /// Initial tempo in beats per minute.
    public let initialTempo: Double

    /// Starting beat for this tempo segment.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMTempoLine: Equatable {
}

// MARK: - Hashable

extension DKMTempoLine: Hashable {
}

// MARK: - Sendable

extension DKMTempoLine: Sendable {
}
