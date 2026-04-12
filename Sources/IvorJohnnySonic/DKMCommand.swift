// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A Johnny Sonic score command.
public enum DKMCommand: String {
    /// Applies a chorus effect.
    case chorus = "Chorus"

    /// Clips the audio signal.
    case clip = "Clip"

    /// A comment; has no effect on playback.
    case comment

    /// Applies dynamic range compression.
    case compress = "Compress"

    /// Adjusts the dynamics of the audio signal.
    case dynamics = "Dynamics"

    /// Marks the end of the score.
    case end = "End"

    /// Excludes a section from processing.
    case exclude = "Exclude"

    /// Applies a filter effect.
    case filter = "Filter"

    /// Applies a flange effect.
    case flange = "Flange"

    /// Performs a frequency band analysis.
    case freqBandAnalyze = "FBA"

    /// Applies a graphic equalizer.
    case geq = "GEQ"

    /// Applies the Haas effect.
    case haas = "Haas"

    /// Includes a section in processing.
    case include = "Include"

    /// Adjusts audio levels.
    case levels = "Levels"

    /// Mixes audio signals together.
    case mix = "Mix"

    /// Adjusts the pitches of the audio signal.
    case pitches = "Pitches"

    /// Generates a pulse waveform.
    case pulse = "Pulse"

    /// Applies a reverb effect.
    case reverb = "Reverb"

    /// Routes audio to the screen output.
    case screenOut = "ScreenOut"

    /// Sends audio to a back channel.
    case sendBack = "SendBack"

    /// Displays the contents of the audio buffer.
    case showBuffer = "ShowBuffer"

    /// Specifies the name of a sound file.
    case soundFileName = "SFN"

    /// Outputs statistics about the audio signal.
    case stats = "Stats"

    /// Sets the tempo of the score.
    case tempo = "Tempo"

    /// Adjusts the tuning of the audio signal.
    case tuning = "Tuning"

    /// Applies a vocoder effect.
    case vocode = "Vocode"
}

// MARK: - Sendable

extension DKMCommand: Sendable {
}
