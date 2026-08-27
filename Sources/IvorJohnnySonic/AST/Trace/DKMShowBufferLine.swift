// © 2026 John Gary Pusey (see LICENSE.md)

/// A line of parameters for displaying raw sample data for a segment of the
/// sound buffer.
///
/// Makes no changes to the sound buffer.
public struct DKMShowBufferLine {

    // MARK: Public Initializers

    /// Creates a new show-buffer line.
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

extension DKMShowBufferLine: Equatable {
}

// MARK: - Hashable

extension DKMShowBufferLine: Hashable {
}

// MARK: - Sendable

extension DKMShowBufferLine: Sendable {
}
