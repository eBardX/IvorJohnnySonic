// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A JohnnySonic score command with typed associated values.
///
/// Commands that produce multiple lines of data in the score file (such as
/// ``tempoLine(_:_:_:_:)`` or ``filterLine(_:_:_:_:_:_:_:)``) are represented
/// by one enum case per data line.  Commands that establish a processing mode
/// and then accept note data use paired `…Mode` and `…Note` cases
/// (``clipMode(_:_:)`` / ``clipNote(_:_:_:_:_:_:_:)`` and
/// ``vocodeMode(_:_:_:_:_:_:_:_:_:)`` / ``vocodeNote(_:_:_:_:_:_:_:)``).
public enum DKMCommand {

    // MARK: Comment

    /// A comment; has no effect on playback.
    ///
    /// The associated value is the comment text, including any leading space.
    /// An empty string produces a bare `!` line.
    case comment(String)

    // MARK: /Chorus

    /// A line of parameters for invoking the choruser on a segment of the sound
    /// buffer.
    ///
    /// - Parameter startBeat:      Starting beat.
    /// - Parameter duration:       Duration in beats.
    /// - Parameter numberOfVoices: Number of voices (typically even, voices are
    ///                             divided across channels).
    /// - Parameter depth:          Comb filter gain (must be less than 1).
    /// - Parameter flipChannels:   When `true`, the chorussed right channel is
    ///                             output to the left channel and vice versa.
    case chorusLine(startBeat: Double,
                    duration: Double,
                    numberOfVoices: Int,
                    depth: Double,
                    flipChannels: Bool)

    // MARK: /Clip

    /// Sets clip mode, specifying the clip channel and clip name.
    ///
    /// Must precede any ``clipNote(_:_:_:_:_:_:_:)`` entries for this clip.
    ///
    /// - Parameter channel:    The clip channel.
    /// - Parameter name:       The clip name (must match an entry in the clip
    ///                         list file).
    case clipMode(channel: DKMClipChannel,
                  name: String)

    /// A note played in clip mode.
    ///
    /// Must follow a ``clipMode(_:_:)`` entry.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter volume:     Absolute volume.
    /// - Parameter location:   Stereo location (–1 to 1).
    /// - Parameter clipStart:  Start position within the clip.
    /// - Parameter clipRate:   Playback rate of the clip.
    /// - Parameter instrument: Instrument name (must match an entry in the
    ///                         instrument file).
    case clipNote(startBeat: Double,
                  duration: Double,
                  volume: Double,
                  location: Double,
                  clipStart: Double,
                  clipRate: Double,
                  instrument: String)

    // MARK: /Compress

    /// A line of parameters for invoking the compressor on a segment of the
    /// sound buffer.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter maxRatio:   Maximum compression ratio (typically 3–15).
    case compressLine(startBeat: Double,
                      duration: Double,
                      maxRatio: Double)

    // MARK: /End

    /// Marks the end of the score.
    ///
    /// Processing stops at this point even if more commands follow.
    case end

    // MARK: /Exclude

    /// Marks the end of an include file.
    ///
    /// Processing continues in the main score file from where it left off.
    case exclude

    // MARK: /FBA

    /// A line of parameters for a frequency band analysis.
    ///
    /// - Parameter startBeat:  Starting beat for the analysis.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter channel:    The channel to analyze.
    /// - Parameter buffer:     The buffer to analyze.
    case freqBandAnalyzeLine(startBeat: Double,
                             duration: Double,
                             channel: DKMFBAChannel,
                             buffer: DKMFBABuffer)

    // MARK: /Filter

    /// A line of parameters for applying an audio filter to a segment of the
    /// sound buffer.
    ///
    /// Pass `–1` for `startBeat` to continue from where the previous filter
    /// line left off.
    ///
    /// - Parameter startBeat:          Starting beat (–1 to continue).
    /// - Parameter duration:           Duration in beats.
    /// - Parameter filterType:         The filter type.
    /// - Parameter initialPitch:       Initial pitch (positive = pitch number;
    ///                                 negative = frequency in Hz).
    /// - Parameter finalPitch:         Final pitch (positive = pitch number;
    ///                                 negative = frequency in Hz).
    /// - Parameter initialBandwidth:   Initial bandwidth (positive = semitones;
    ///                                 negative = Hz); applies to types 1, 2, 5, 6 only.
    /// - Parameter finalBandwidth:     Final bandwidth (positive = semitones;
    ///                                 negative = Hz); applies to types 1, 2, 5, 6 only.
    case filterLine(startBeat: Double,
                    duration: Double,
                    filterType: DKMFilterType,
                    initialPitch: Double,
                    finalPitch: Double,
                    initialBandwidth: Double,
                    finalBandwidth: Double)

    // MARK: /Flange

    /// A line of parameters for invoking the flanger on a segment of the sound
    /// buffer.
    ///
    /// - Parameter startBeat:      Starting beat.
    /// - Parameter duration:       Duration in beats.
    /// - Parameter numberOfVoices: Number of voices (typically even, voices are
    ///                             divided across channels).
    /// - Parameter depth:          Comb filter gain (must be less than 1).
    /// - Parameter flipChannels:   When `true`, the flanged right channel is
    ///                             output to the left channel and vice versa.
    case flangeLine(startBeat: Double,
                    duration: Double,
                    numberOfVoices: Int,
                    depth: Double,
                    flipChannels: Bool)

    // MARK: /GEQ

    /// A line of parameters for a graphic equalizer segment.
    ///
    /// The first line’s beat is the start of the segment; the last line’s beat
    /// is the end. Each line specifies gains for all 30 frequency bands.
    ///
    /// - Parameter beat:       Beat position for this line.
    /// - Parameter bandGains:  Gain (in dB) for each frequency band (up to 30).
    case geqLine(beat: Double,
                 bandGains: [Double])

    // MARK: /Haas

    /// Sets the global Haas effect parameters.
    ///
    /// Affects all subsequent notes until changed by another ``haas(_:_:_:_:)``
    /// command.  Haas is disabled by default.
    ///
    /// - Parameter enabled:     `true` to enable the Haas effect.
    /// - Parameter minDelay:    Minimum delay in milliseconds (0–40).
    /// - Parameter maxDelay:    Maximum delay in milliseconds (0–90).
    /// - Parameter reverbSend:  `true` to send to reverb.
    case haas(enabled: Bool,
              minDelay: Double,
              maxDelay: Double,
              reverbSend: Bool)

    // MARK: /Include

    /// Processes an include file before continuing with the main score file.
    ///
    /// - Parameter fileName:  Path to the include file.  Include files cannot
    ///                        be nested.
    case include(String)

    // MARK: /Levels

    /// A line of parameters for adjusting levels on a segment of the sound
    /// buffer.
    ///
    /// Pass `–1` for `startBeat` to continue from where the previous levels
    /// line left off.
    ///
    /// - Parameter startBeat:          Starting beat (–1 to continue).
    /// - Parameter duration:           Duration in beats.
    /// - Parameter startGainLossdB:    Initial gain/loss in dB.
    /// - Parameter endGainLossdB:      Final gain/loss in dB.
    case levelsLine(startBeat: Double,
                    duration: Double,
                    startGainLossdB: Double,
                    endGainLossdB: Double)

    // MARK: /Mix

    /// A line of parameters for mixing the sound and Haas buffers into the mix
    /// buffer.
    ///
    /// Pass `–1` for `startBeat` to continue from where the previous mix line
    /// left off.
    ///
    /// - Parameter startBeat:          Starting beat (–1 to continue).
    /// - Parameter duration:           Duration in beats.
    /// - Parameter gainLossdB:         Gain/loss in dB.
    /// - Parameter keepSoundBuffer:    `true` to retain the sound and Haas
    ///                                 buffers; `false` to clear them after
    ///                                 mixing.
    /// - Parameter sign:               Sign factor; use `–1` to invert.
    /// - Parameter timeOffset:         Time offset in seconds (can be positive
    ///                                 or negative).
    case mixLine(startBeat: Double,
                 duration: Double,
                 gainLossdB: Double,
                 keepSoundBuffer: Bool,
                 sign: Double,
                 timeOffset: Double)

    // MARK: /Pitches

    /// A note in default (pitch) mode.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    /// - Parameter volume:     Absolute volume.
    /// - Parameter location:   Stereo location (–1 to 1).
    /// - Parameter startPitch: Starting pitch (positive = pitch number;
    ///                         negative = frequency in Hz).
    /// - Parameter endPitch:   Ending pitch (positive = pitch number; negative
    ///                         = frequency in Hz).
    /// - Parameter instrument: Instrument name (must match an entry in the
    ///                         instrument file).
    case pitchesNote(startBeat: Double,
                     duration: Double,
                     volume: Double,
                     location: Double,
                     startPitch: Double,
                     endPitch: Double,
                     instrument: String)

    // MARK: /Pulse

    /// A one-sample pulse inserted into the sound buffer.
    ///
    /// Useful for testing processors such as reverb and filters.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter channel:    The channel to receive the pulse.
    case pulseLine(startBeat: Double,
                   channel: DKMChannel)

    // MARK: /Reverb

    /// A line of parameters for invoking the reverberator on a segment of the
    /// sound buffer.
    ///
    /// - Parameter startBeat:          Starting beat.
    /// - Parameter duration:           Duration in beats.
    /// - Parameter direction:          Reverb direction.
    /// - Parameter size:               Room size.
    /// - Parameter reverbTime:         60 dB reverb time in seconds.
    /// - Parameter combFilterDryGain:  Gain on the dry signal.
    /// - Parameter xTalkFactor:        Cross-channel gain factor (0–1).
    /// - Parameter wetness:            Mix of wet/dry on output (0–1).
    case reverbLine(startBeat: Double,
                    duration: Double,
                    direction: DKMReverbDirection,
                    size: DKMReverbSize,
                    reverbTime: Double,
                    combFilterDryGain: Double,
                    xTalkFactor: Double,
                    wetness: Double)

    // MARK: /ScreenOut

    /// Sets the screen output level.
    ///
    /// Overrides the default level of ``DKMScreenLevel/verbose`` and may be
    /// changed repeatedly throughout the score.
    ///
    /// - Parameter level:  The desired screen output level.
    case screenOut(DKMScreenLevel)

    // MARK: /SendBack

    /// A line of parameters for sending a segment of the mix buffer back to the
    /// sound buffer.
    ///
    /// The sound buffer is overwritten at the specified segment, and that
    /// segment of the mix buffer is cleared.
    ///
    /// - Parameter startBeat:   Starting beat.
    /// - Parameter duration:    Duration in beats.
    /// - Parameter gainLossdB:  Gain/loss in dB.
    case sendBackLine(startBeat: Double,
                      duration: Double,
                      gainLossdB: Double)

    // MARK: /SFN

    /// Specifies the name of the output sound file, overriding the name
    /// provided on the command line.
    ///
    /// - Parameter name:  Path to the output sound file to create.
    case soundFileName(String)

    // MARK: /ShowBuffer

    /// A line of parameters for displaying raw sample data for a segment of the
    /// sound buffer.
    ///
    /// Makes no changes to the sound buffer.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    case showBufferLine(startBeat: Double,
                        duration: Double)

    // MARK: /Stats

    /// A line of parameters for displaying peak data for a segment of the sound
    /// buffer.
    ///
    /// Makes no changes to the sound buffer.
    ///
    /// - Parameter startBeat:  Starting beat.
    /// - Parameter duration:   Duration in beats.
    case statsLine(startBeat: Double,
                   duration: Double)

    // MARK: /Tempo

    /// A line of parameters defining the tempo or a tempo change.
    ///
    /// If no ``tempoLine(_:_:_:_:)`` is present, the default tempo of 60 BPM is
    /// used.  Changes use linear interpolation and occur on whole-number beats.
    ///
    /// - Parameter startBeat:      Starting beat for this tempo segment.
    /// - Parameter duration:       Duration of the tempo change in beats.
    /// - Parameter initialTempo:   Initial tempo in beats per minute.
    /// - Parameter finalTempo:     Final tempo in beats per minute.
    case tempoLine(startBeat: Double,
                   duration: Double,
                   initialTempo: Double,
                   finalTempo: Double)

    // MARK: /Tuning

    /// Sets the tuning parameters for equal-tempered pitch conversion.
    ///
    /// May appear multiple times in a score.  For non-equal-tempered tunings,
    /// specify pitches in Hz (negative values).
    ///
    /// - Parameter primaryInterval:    The primary interval (must be > 1;
    ///                                 default 2 for octave).
    /// - Parameter notesPerInterval:   Notes per primary interval (must be
    ///                                 > 1; default 12 for 12-TET).
    /// - Parameter pitchConvExponent:  Pitch conversion exponent (must be
    ///                                 > 0; default 3).
    /// - Parameter pitchConvFactor:    Pitch conversion factor (must be > 0;
    ///                                 default ≈ 1.021974864).
    case tuning(primaryInterval: Double,
                notesPerInterval: Double,
                pitchConvExponent: Double,
                pitchConvFactor: Double)

    // MARK: /Vocode

    /// Sets vocode mode, specifying the clip source and vocoder parameters.
    ///
    /// Must precede any ``vocodeNote(_:_:_:_:_:_:_:)`` entries for this vocoder
    /// configuration.
    ///
    /// - Parameter channel:        The clip channel.
    /// - Parameter name:           The clip name (must match an entry in the
    ///                             clip list file).
    /// - Parameter clipRate:       Playback rate of the clip.
    /// - Parameter maxHarm:        Maximum harmonic limit (0 = Nyquist limit;
    ///                             1 = fundamental only; 2+ = specific limit).
    /// - Parameter slope:          dB/octave slope applied to gain (–8 to 8).
    /// - Parameter bassBoost:      Bass boost/cut in dB (–15 to 15).
    /// - Parameter dynExponent:    Dynamic range expansion/compression exponent
    ///                             (0.25–4.0; default 1).
    /// - Parameter shiftN:         Spectrum shift in bands, out of 16 (–15 to
    ///                             15).
    /// - Parameter peakReduction:  Loudest formant reduction in dB (0–12).
    case vocodeMode(channel: DKMClipChannel,
                    name: String,
                    clipRate: Double,
                    maxHarm: Int,
                    slope: Double,
                    bassBoost: Double,
                    dynExponent: Double,
                    shiftN: Int,
                    peakReduction: Double)

    /// A note played in vocode mode.
    ///
    /// Must follow a ``vocodeMode(_:_:_:_:_:_:_:_:_:)`` entry.
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
    case vocodeNote(startBeat: Double,
                    duration: Double,
                    volume: Double,
                    location: Double,
                    pitch: Double,
                    clipStart: Double,
                    instrument: String)
}

// MARK: - Equatable

extension DKMCommand: Equatable {
}

// MARK: - Sendable

extension DKMCommand: Sendable {
}
