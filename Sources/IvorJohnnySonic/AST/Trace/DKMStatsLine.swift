// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for displaying peak data for a segment of the sound
/// buffer.
///
/// Makes no changes to the sound buffer.
public struct DKMStatsLine {

    // MARK: Public Initializers

    /// Creates a new stats line.
    ///
    /// - Parameter startBeat: Starting beat.
    /// - Parameter duration:  Duration in beats.
    public init(startBeat: Double,
                duration: Double) {
        self.startBeat = startBeat
        self.duration = duration
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMStatsLine: Equatable {
}

// MARK: - Hashable

extension DKMStatsLine: Hashable {
}

// MARK: - Sendable

extension DKMStatsLine: Sendable {
}
