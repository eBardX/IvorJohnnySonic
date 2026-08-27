// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for invoking the compressor on a segment of the
/// sound buffer.
public struct DKMCompressLine {

    // MARK: Public Initializers

    /// Creates a new compress line.
    ///
    /// - Parameter startBeat: Starting beat.
    /// - Parameter duration:  Duration in beats.
    /// - Parameter maxRatio:  Maximum compression ratio (typically 3–15).
    public init(startBeat: Double,
                duration: Double,
                maxRatio: Double) {
        self.startBeat = startBeat
        self.duration = duration
        self.maxRatio = maxRatio
    }

    // MARK: Public Instance Properties

    /// Duration in beats.
    public let duration: Double

    /// Maximum compression ratio (typically 3–15).
    public let maxRatio: Double

    /// Starting beat.
    public let startBeat: Double
}

// MARK: - Equatable

extension DKMCompressLine: Equatable {
}

// MARK: - Hashable

extension DKMCompressLine: Hashable {
}

// MARK: - Sendable

extension DKMCompressLine: Sendable {
}
