// © 2026 John Gary Pusey (see LICENSE.md)

/// A command that sets the tuning parameters for equal-tempered pitch
/// conversion.
///
/// May appear multiple times in a score. For non-equal-tempered tunings,
/// specify pitches in Hz (negative values).
public struct DKMTuning {

    // MARK: Public Initializers

    /// Creates a new tuning command.
    ///
    /// - Parameter primaryInterval:   The primary interval (must be > 1;
    ///                                default 2 for octave).
    /// - Parameter notesPerInterval:  Notes per primary interval (must be
    ///                                > 1; default 12 for 12-TET).
    /// - Parameter pitchConvExponent: Pitch conversion exponent (must be
    ///                                > 0; default 3).
    /// - Parameter pitchConvFactor:   Pitch conversion factor (must be > 0;
    ///                                default ≈ 1.021974864).
    public init(primaryInterval: Double,
                notesPerInterval: Double,
                pitchConvExponent: Double,
                pitchConvFactor: Double) {
        self.primaryInterval = primaryInterval
        self.notesPerInterval = notesPerInterval
        self.pitchConvExponent = pitchConvExponent
        self.pitchConvFactor = pitchConvFactor
    }

    // MARK: Public Instance Properties

    /// Notes per primary interval (must be > 1; default 12 for 12-TET).
    public let notesPerInterval: Double

    /// Pitch conversion exponent (must be > 0; default 3).
    public let pitchConvExponent: Double

    /// Pitch conversion factor (must be > 0; default ≈ 1.021974864).
    public let pitchConvFactor: Double

    /// The primary interval (must be > 1; default 2 for octave).
    public let primaryInterval: Double
}

// MARK: - Equatable

extension DKMTuning: Equatable {
}

// MARK: - Hashable

extension DKMTuning: Hashable {
}

// MARK: - Sendable

extension DKMTuning: Sendable {
}
