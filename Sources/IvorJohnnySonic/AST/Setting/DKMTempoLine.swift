// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters defining the tempo or a tempo change.
///
/// If no ``DKMTempoLine`` is present, the default tempo of 60 BPM is used.
/// Changes use linear interpolation and occur on whole-number beats.
public struct DKMTempoLine {

    // MARK: Public Initializers

    /// Creates a new tempo line.
    ///
    /// - Parameter startBeat:  Start beat for this tempo segment.
    /// - Parameter duration:   Duration of the tempo change in beats.
    /// - Parameter startTempo: Start tempo in beats per minute.
    /// - Parameter endTempo:   End tempo in beats per minute.
    public init(startBeat: Double,
                duration: Double,
                startTempo: Double,
                endTempo: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.startTempo = startTempo
        self.endTempo = endTempo
    }

    // MARK: Public Instance Properties

    /// Duration of the tempo change in beats.
    public let duration: Double

    /// End tempo in beats per minute.
    public let endTempo: Double

    /// Start beat for this tempo segment.
    public let startBeat: Double

    /// Start tempo in beats per minute.
    public let startTempo: Double
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
