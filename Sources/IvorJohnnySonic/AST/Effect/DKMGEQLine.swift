// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for a graphic equalizer segment.
///
/// The first line’s beat is the start of the segment; the last line’s beat
/// is the end. Each line specifies gains for all 30 frequency bands.
public struct DKMGEQLine {

    // MARK: Public Initializers

    /// Creates a new GEQ line.
    ///
    /// - Parameter beat:      Beat position for this line.
    /// - Parameter bandGains: Gain (in dB) for each frequency band (up to 30).
    public init(beat: Double,
                bandGains: [Double]) {
        self.beat = beat
        self.bandGains = bandGains
    }

    // MARK: Public Instance Properties

    /// Gain (in dB) for each frequency band (up to 30).
    public let bandGains: [Double]

    /// Beat position for this line.
    public let beat: Double
}

// MARK: - Equatable

extension DKMGEQLine: Equatable {
}

// MARK: - Hashable

extension DKMGEQLine: Hashable {
}

// MARK: - Sendable

extension DKMGEQLine: Sendable {
}
