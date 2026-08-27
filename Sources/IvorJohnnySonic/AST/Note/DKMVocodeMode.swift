// © 2026 John Gary Pusey (see LICENSE.md)

/// A command that sets vocode mode, specifying the clip source and vocoder
/// parameters.
///
/// Must precede any ``DKMVocodeNote`` entries for this vocoder configuration.
public struct DKMVocodeMode {

    // MARK: Public Initializers

    /// Creates a new vocode mode command.
    ///
    /// - Parameter channel:       The clip channel.
    /// - Parameter name:          The clip name (must match an entry in the
    ///                            clip list file).
    /// - Parameter clipRate:      Playback rate of the clip.
    /// - Parameter maxHarm:       Maximum harmonic limit (0 = Nyquist limit;
    ///                            1 = fundamental only; 2+ = specific limit).
    /// - Parameter slope:         dB/octave slope applied to gain (–8 to 8).
    /// - Parameter bassBoost:     Bass boost/cut in dB (–15 to 15).
    /// - Parameter dynExponent:   Dynamic range expansion/compression exponent
    ///                            (0.25–4.0; default 1).
    /// - Parameter shiftN:        Spectrum shift in bands (–128 to 128; the
    ///                            reference implementation’s FFT divides
    ///                            into 128 frequency bands, not 16).
    /// - Parameter peakReduction: Loudest formant reduction in dB (0–12).
    public init(channel: DKMClipChannel,
                name: String,
                clipRate: Double,
                maxHarm: Int,
                slope: Double,
                bassBoost: Double,
                dynExponent: Double,
                shiftN: Int,
                peakReduction: Double) {
        self.channel = channel
        self.name = name
        self.clipRate = clipRate
        self.maxHarm = maxHarm
        self.slope = slope
        self.bassBoost = bassBoost
        self.dynExponent = dynExponent
        self.shiftN = shiftN
        self.peakReduction = peakReduction
    }

    // MARK: Public Instance Properties

    /// Bass boost/cut in dB (–15 to 15).
    public let bassBoost: Double

    /// The clip channel.
    public let channel: DKMClipChannel

    /// Playback rate of the clip.
    public let clipRate: Double

    /// Dynamic range expansion/compression exponent (0.25–4.0; default 1).
    public let dynExponent: Double

    /// Maximum harmonic limit (0 = Nyquist limit; 1 = fundamental only;
    /// 2+ = specific limit).
    public let maxHarm: Int

    /// The clip name (must match an entry in the clip list file).
    public let name: String

    /// Loudest formant reduction in dB (0–12).
    public let peakReduction: Double

    /// Spectrum shift in bands (–128 to 128; the reference implementation’s
    /// FFT divides into 128 frequency bands, not 16).
    public let shiftN: Int

    /// dB/octave slope applied to gain (–8 to 8).
    public let slope: Double
}

// MARK: - Equatable

extension DKMVocodeMode: Equatable {
}

// MARK: - Hashable

extension DKMVocodeMode: Hashable {
}

// MARK: - Sendable

extension DKMVocodeMode: Sendable {
}
