// © 2026 John Gary Pusey (see LICENSE.md)

/// A note played in clip mode.
///
/// Must follow a ``DKMClipMode`` entry.
public struct DKMClipNote {

    // MARK: Public Initializers

    /// Creates a new clip note.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter volume:     Absolute volume.
    /// - Parameter location:   Stereo location (–1 to 1).
    /// - Parameter clipStart:  Start position within the clip.
    /// - Parameter clipRate:   Playback rate of the clip.
    /// - Parameter instrument: Instrument name (must match an entry in the
    ///                         instrument file).
    public init(startBeat: Double,
                duration: Double,
                volume: Double,
                location: Double,
                clipStart: Double,
                clipRate: Double,
                instrument: String) {
        self.startBeat = startBeat
        self.duration = duration
        self.volume = volume
        self.location = location
        self.clipStart = clipStart
        self.clipRate = clipRate
        self.instrument = instrument
    }

    // MARK: Public Instance Properties

    /// Playback rate of the clip.
    public let clipRate: Double

    /// Start position within the clip.
    public let clipStart: Double

    /// Duration in beats.
    public let duration: Double

    /// Instrument name (must match an entry in the instrument file).
    public let instrument: String

    /// Stereo location (–1 to 1).
    public let location: Double

    /// Starting beat.
    public let startBeat: Double

    /// Absolute volume.
    public let volume: Double
}

// MARK: - Equatable

extension DKMClipNote: Equatable {
}

// MARK: - Hashable

extension DKMClipNote: Hashable {
}

// MARK: - Sendable

extension DKMClipNote: Sendable {
}
