// © 2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

extension DKMFormatter {

    // MARK: Internal Nested Types

    internal struct Writer {

        // MARK: Internal Initializers

        internal init(score: DKMScore) {
            self.buffer = ""
            self.previousSection = nil
            self.score = score
        }

        // MARK: Private Instance Properties

        private let score: DKMScore

        private var buffer: String
        private var previousSection: String?
    }
}

// MARK: -

extension DKMFormatter.Writer {

    // MARK: Internal Instance Methods

    internal mutating func writeScore() throws(DKMFormatter.Error) -> Data {
        for command in score.commands {
            try _writeCommand(command)
        }

        guard let data = buffer.data(using: .utf8)
        else { throw DKMFormatter.Error.stringConversionFailed }

        return data
    }

    // MARK: Private Instance Methods

    private func _validateString(_ string: String) throws(DKMFormatter.Error) -> String {
        guard !string.contains(where: \.isNewline)
        else { throw DKMFormatter.Error.invalidStringArgument(string) }

        return string
    }

    private mutating func _writeCommand(_ command: DKMCommand) throws(DKMFormatter.Error) {
        switch command {
        case let .chorusLine(line):
            _writeSection("Chorus")
            _writeLine("\(line.startBeat) \(line.duration) \(line.numberOfVoices) \(line.depth) \(line.flipChannels ? 1 : 0)")

        case let .clipMode(mode):
            _writeSection("Clip",
                          force: true)

            try _writeLine("\(mode.channel.rawValue) \(_validateString(mode.name))")

        case let .clipNote(note):
            try _writeLine("\(note.startBeat) \(note.duration) \(note.volume) \(note.location)"
                           + " \(note.clipStart) \(note.clipRate) \(_validateString(note.instrument))")

        case let .comment(text):
            buffer.append("!")
            buffer.append(text)
            buffer.append("\n")

        case let .compressLine(line):
            _writeSection("Compress")
            _writeLine("\(line.startBeat) \(line.duration) \(line.maxRatio)")

        case .dynamics:
            _writeSection("Dynamics")

        case .end:
            _writeSection("End")

        case .exclude:
            _writeSection("Exclude")

        case let .filterLine(line):
            _writeSection("Filter")
            _writeLine("\(line.startBeat) \(line.duration) \(line.filterType.rawValue) \(line.initialPitch)"
                       + " \(line.finalPitch) \(line.initialBandwidth) \(line.finalBandwidth)")

        case let .flangeLine(line):
            _writeSection("Flange")
            _writeLine("\(line.startBeat) \(line.duration) \(line.numberOfVoices) \(line.depth) \(line.flipChannels ? 1 : 0)")

        case let .freqBandAnalyzeLine(line):
            _writeSection("FBA")
            _writeLine("\(line.startBeat) \(line.duration) \(line.channel.rawValue) \(line.buffer.rawValue)")

        case let .geqLine(line):
            _writeSection("GEQ")

            let gains = line.bandGains.map { "\($0)" }.joined(separator: " ")

            if gains.isEmpty {
                _writeLine("\(line.beat)")
            } else {
                _writeLine("\(line.beat) \(gains)")
            }

        case let .haas(haas):
            _writeSection("Haas")
            _writeLine("\(haas.enabled ? 1 : 0) \(haas.minDelay) \(haas.maxDelay) \(haas.reverbSend ? 1 : 0)")

        case let .include(fileName):
            _writeSection("Include")
            try _writeLine(_validateString(fileName))

        case let .levelsLine(line):
            _writeSection("Levels")
            _writeLine("\(line.startBeat) \(line.duration) \(line.startGainLossdB) \(line.endGainLossdB)")

        case let .mixLine(line):
            _writeSection("Mix")
            _writeLine("\(line.startBeat) \(line.duration) \(line.gainLossdB) \(line.keepSoundBuffer ? 1 : 0) \(line.sign) \(line.timeOffset)")

        case let .pitchesNote(note):
            _writeSection("Pitches")

            try _writeLine("\(note.startBeat) \(note.duration) \(note.volume) \(note.location)"
                           + " \(note.startPitch) \(note.endPitch) \(_validateString(note.instrument))")

        case let .pulseLine(line):
            _writeSection("Pulse")
            _writeLine("\(line.startBeat) \(line.channel.rawValue)")

        case let .reverbLine(line):
            _writeSection("Reverb")
            _writeLine("\(line.startBeat) \(line.duration) \(line.direction.rawValue) \(line.size.rawValue)"
                       + " \(line.reverbTime) \(line.combFilterDryGain) \(line.xTalkFactor) \(line.wetness)")

        case let .screenOut(level):
            _writeSection("ScreenOut")
            _writeLine("\(level.rawValue)")

        case let .sendBackLine(line):
            _writeSection("SendBack")
            _writeLine("\(line.startBeat) \(line.duration) \(line.gainLossdB)")

        case let .showBufferLine(line):
            _writeSection("ShowBuffer")
            _writeLine("\(line.startBeat) \(line.duration)")

        case let .soundFileName(name):
            _writeSection("SFN")

            try _writeLine(_validateString(name))

        case let .statsLine(line):
            _writeSection("Stats")
            _writeLine("\(line.startBeat) \(line.duration)")

        case let .tempoLine(line):
            _writeSection("Tempo")
            _writeLine("\(line.startBeat) \(line.duration) \(line.initialTempo) \(line.finalTempo)")

        case let .tuning(tuning):
            _writeSection("Tuning")
            _writeLine("\(tuning.primaryInterval) \(tuning.notesPerInterval) \(tuning.pitchConvExponent) \(tuning.pitchConvFactor)")

        case let .vocodeMode(mode):
            _writeSection("Vocode",
                          force: true)

            try _writeLine("\(mode.channel.rawValue) \(_validateString(mode.name)) \(mode.clipRate) \(mode.maxHarm)"
                           + " \(mode.slope) \(mode.bassBoost) \(mode.dynExponent) \(mode.shiftN) \(mode.peakReduction)")

        case let .vocodeNote(note):
            try _writeLine("\(note.startBeat) \(note.duration) \(note.volume) \(note.location)"
                           + " \(note.pitch) \(note.clipStart) \(_validateString(note.instrument))")
        }
    }

    private mutating func _writeLine(_ line: String) {
        buffer.append(line)
        buffer.append("\n")
    }

    private mutating func _writeSection(_ section: String,
                                        force: Bool = false) {
        // Writes `/Section\n` when the section changes; always writes when
        // `force` is `true` (used by mode-setting commands such as `/Clip` and
        // `/Vocode` that must restate their section for each new mode block).
        guard force || section != previousSection
        else { return }

        previousSection = section

        buffer.append("/")
        buffer.append(section)
        buffer.append("\n")
    }
}
