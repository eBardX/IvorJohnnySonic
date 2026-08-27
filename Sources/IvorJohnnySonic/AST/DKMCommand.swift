// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A JohnnySonic score command.
///
/// Commands whose case carries more than one associated value wrap them in a
/// dedicated, immutable type (such as ``DKMTempoLine`` or ``DKMFilterLine``)
/// rather than exposing several loose associated values. Commands that
/// produce multiple lines of data in the score file (such as
/// ``tempoLine(_:)`` or ``filterLine(_:)``) are represented by one enum case
/// per data line. Commands that establish a processing mode and then accept
/// note data use paired `…Mode` and `…Note` cases (``clipMode(_:)`` /
/// ``clipNote(_:)`` and ``vocodeMode(_:)`` / ``vocodeNote(_:)``).
public enum DKMCommand {

    /// A line of parameters for invoking the choruser on a segment of the
    /// sound buffer.
    case chorusLine(DKMChorusLine)

    /// A command that sets clip mode, specifying the clip channel and clip
    /// name.
    ///
    /// Must precede any ``clipNote(_:)`` entries for this clip.
    case clipMode(DKMClipMode)

    /// A note played in clip mode.
    ///
    /// Must follow a ``clipMode(_:)`` entry.
    case clipNote(DKMClipNote)

    /// A comment; has no effect on playback.
    ///
    /// The associated value is the comment text, including any leading space.
    /// An empty string produces a bare `!` line.
    case comment(String)

    /// A line of parameters for invoking the compressor on a segment of the
    /// sound buffer.
    case compressLine(DKMCompressLine)

    /// A `/DYN` section header.
    ///
    /// The reference implementation’s `ProcessDynamics` is a stub that names
    /// itself and skips the section, so this command has no effect on the
    /// rendered sound and carries no data.
    ///
    /// Because the formatter suppresses repeated section headers, two adjacent
    /// ``dynamics`` commands collapse to a single `/Dynamics` line when
    /// written — consistent with how the format’s other section headers
    /// behave.
    case dynamics

    /// A command that marks the end of the score.
    ///
    /// Processing stops at this point even if more commands follow.
    case end

    /// A command that marks the end of an include file.
    ///
    /// Processing continues in the main score file from where it left off.
    case exclude

    /// A line of parameters for applying an audio filter to a segment of the
    /// sound buffer.
    case filterLine(DKMFilterLine)

    /// A line of parameters for invoking the flanger on a segment of the sound
    /// buffer.
    case flangeLine(DKMFlangeLine)

    /// A line of parameters for a frequency band analysis.
    case freqBandAnalyzeLine(DKMFreqBandAnalyzeLine)

    /// A line of parameters for a graphic equalizer segment.
    case geqLine(DKMGEQLine)

    /// A command that sets the global Haas effect parameters.
    ///
    /// Affects all subsequent notes until changed by another ``haas(_:)``
    /// command. Haas is disabled by default.
    case haas(DKMHaas)

    /// A command that processes an include file before continuing with the
    /// main score file.
    ///
    /// - Parameter fileName:  Path to the include file.  Include files cannot
    ///                        be nested.
    case include(String)

    /// A line of parameters for adjusting levels on a segment of the sound
    /// buffer.
    case levelsLine(DKMLevelsLine)

    /// A line of parameters for mixing the sound and Haas buffers into the mix
    /// buffer.
    case mixLine(DKMMixLine)

    /// A note in default (pitch) mode.
    case pitchesNote(DKMPitchesNote)

    /// A one-sample pulse inserted into the sound buffer.
    ///
    /// Useful for testing processors such as reverb and filters.
    case pulseLine(DKMPulseLine)

    /// A line of parameters for invoking the reverberator on a segment of the
    /// sound buffer.
    case reverbLine(DKMReverbLine)

    /// A command that sets the screen output level.
    ///
    /// Overrides the default level of ``DKMScreenLevel/verbose`` and may be
    /// changed repeatedly throughout the score.
    ///
    /// - Parameter level:  The desired screen output level.
    case screenOut(DKMScreenLevel)

    /// A line of parameters for sending a segment of the mix buffer back to
    /// the sound buffer.
    ///
    /// The sound buffer is overwritten at the specified segment, and that
    /// segment of the mix buffer is cleared.
    case sendBackLine(DKMSendBackLine)

    /// A line of parameters for displaying raw sample data for a segment of
    /// the sound buffer.
    ///
    /// Makes no changes to the sound buffer.
    case showBufferLine(DKMShowBufferLine)

    /// A command that specifies the name of the output sound file,
    /// overriding the name provided on the command line.
    ///
    /// - Parameter name:  Path to the output sound file to create.
    case soundFileName(String)

    /// A line of parameters for displaying peak data for a segment of the
    /// sound buffer.
    ///
    /// Makes no changes to the sound buffer.
    case statsLine(DKMStatsLine)

    /// A line of parameters defining the tempo or a tempo change.
    ///
    /// If no ``tempoLine(_:)`` is present, the default tempo of 60 BPM is
    /// used. Changes use linear interpolation and occur on whole-number
    /// beats.
    case tempoLine(DKMTempoLine)

    /// A command that sets the tuning parameters for equal-tempered pitch
    /// conversion.
    ///
    /// May appear multiple times in a score. For non-equal-tempered tunings,
    /// specify pitches in Hz (negative values).
    case tuning(DKMTuning)

    /// A command that sets vocode mode, specifying the clip source and
    /// vocoder parameters.
    ///
    /// Must precede any ``vocodeNote(_:)`` entries for this vocoder
    /// configuration.
    case vocodeMode(DKMVocodeMode)

    /// A note played in vocode mode.
    ///
    /// Must follow a ``vocodeMode(_:)`` entry.
    case vocodeNote(DKMVocodeNote)
}

// MARK: - Equatable

extension DKMCommand: Equatable {
}

// MARK: - Hashable

extension DKMCommand: Hashable {
}

// MARK: - Sendable

extension DKMCommand: Sendable {
}
