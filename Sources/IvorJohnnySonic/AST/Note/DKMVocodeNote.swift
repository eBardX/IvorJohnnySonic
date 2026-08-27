// © 2026 John Gary Pusey (see LICENSE.md)

/// A note played in vocode mode.
///
/// Must follow a ``DKMVocodeMode`` entry.
public struct DKMVocodeNote {

    // MARK: Public Initializers

    /// Creates a new vocode note.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter volume:     Absolute volume.
    /// - Parameter location:   Stereo location (–1 to 1).
    /// - Parameter pitch:      Pitch (positive = pitch number; negative =
    ///                         frequency in Hz).
    /// - Parameter clipStart:  Start position within the clip.
    /// - Parameter instrument: Instrument name (must match an entry in the
    ///                         instrument file).
    public init(startBeat: Double,
                duration: Double,
                volume: Double,
                location: Double,
                pitch: Double,
                clipStart: Double,
                instrument: String) {
        self.startBeat = startBeat
        self.duration = duration
        self.volume = volume
        self.location = location
        self.pitch = pitch
        self.clipStart = clipStart
        self.instrument = instrument
    }

    // MARK: Public Instance Properties

    /// Start position within the clip.
    public let clipStart: Double

    /// Duration in beats.
    public let duration: Double

    /// Instrument name (must match an entry in the instrument file).
    public let instrument: String

    /// Stereo location (–1 to 1).
    public let location: Double

    /// Pitch (positive = pitch number; negative = frequency in Hz).
    public let pitch: Double

    /// Starting beat.
    public let startBeat: Double

    /// Absolute volume.
    public let volume: Double
}

// MARK: - Equatable

extension DKMVocodeNote: Equatable {
}

// MARK: - Hashable

extension DKMVocodeNote: Hashable {
}

// MARK: - Sendable

extension DKMVocodeNote: Sendable {
}
