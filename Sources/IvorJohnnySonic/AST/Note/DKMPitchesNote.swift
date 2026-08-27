// © 2026 John Gary Pusey (see LICENSE.md)

/// A note played in default (pitch) mode.
public struct DKMPitchesNote {

    // MARK: Public Initializers

    /// Creates a new pitches note.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter volume:     Absolute volume.
    /// - Parameter location:   Stereo location (–1 to 1).
    /// - Parameter startPitch: Starting pitch (positive = pitch number;
    ///                         negative = frequency in Hz).
    /// - Parameter endPitch:   Ending pitch (positive = pitch number; negative
    ///                         = frequency in Hz).
    /// - Parameter instrument: Instrument name (must match an entry in the
    ///                         instrument file).
    public init(startBeat: Double,
                duration: Double,
                volume: Double,
                location: Double,
                startPitch: Double,
                endPitch: Double,
                instrument: String) {
        self.startBeat = startBeat
        self.duration = duration
        self.volume = volume
        self.location = location
        self.startPitch = startPitch
        self.endPitch = endPitch
        self.instrument = instrument
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Ending pitch (positive = pitch number; negative = frequency in Hz).
    public let endPitch: Double

    /// Instrument name (must match an entry in the instrument file).
    public let instrument: String

    /// Stereo location (–1 to 1).
    public let location: Double

    /// Starting beat.
    public let startBeat: Double

    /// Starting pitch (positive = pitch number; negative = frequency in Hz).
    public let startPitch: Double

    /// Absolute volume.
    public let volume: Double
}

// MARK: - Equatable

extension DKMPitchesNote: Equatable {
}

// MARK: - Hashable

extension DKMPitchesNote: Hashable {
}

// MARK: - Sendable

extension DKMPitchesNote: Sendable {
}
