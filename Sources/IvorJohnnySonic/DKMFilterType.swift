// © 2026 John Gary Pusey (see LICENSE.md)

/// A filter type for a JohnnySonic filter command.
public enum DKMFilterType: Int {
    /// All-pole bandpass with zero dB gain at passband.
    case allPoleBandpassZeroDBGain = 1

    /// All-pole bandpass with power output equal to power input.
    case allPoleBandpassPowerPreserving = 2

    /// Butterworth lowpass filter.
    case butterworthLowpass = 3

    /// Butterworth highpass filter.
    case butterworthHighpass = 4

    /// Butterworth bandpass filter.
    case butterworthBandpass = 5

    /// Butterworth notch filter.
    case butterworthNotch = 6

    /// FIR lowpass filter.
    case firLowpass = 13

    /// FIR highpass filter.
    case firHighpass = 14

    /// FIR notch filter (LP @ 0.91 × freq + HP @ 1.1 × freq).
    case firNotch = 16
}

// MARK: - Sendable

extension DKMFilterType: Sendable {
}
