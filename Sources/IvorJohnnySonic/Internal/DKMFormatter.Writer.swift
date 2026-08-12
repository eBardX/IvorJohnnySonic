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

    internal mutating func writeScore() throws -> Data {
        for command in score.commands {
            try _writeCommand(command)
        }

        guard let data = buffer.data(using: .utf8)
        else { throw DKMFormatError.stringConversionFailed }

        return data
    }

    // MARK: Private Instance Methods

    private func _validateString(_ string: String) throws -> String {
        guard !string.contains(where: \.isNewline)
        else { throw DKMFormatError.invalidStringArgument(string) }

        return string
    }

    private mutating func _writeCommand(_ command: DKMCommand) throws {
        switch command {
        case let .chorusLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            _writeSection("Chorus")
            _writeLine("\(startBeat) \(duration) \(numberOfVoices) \(depth) \(flipChannels ? 1 : 0)")

        case let .clipMode(channel, name):
            _writeSection("Clip",
                          force: true)

            try _writeLine("\(channel.rawValue) \(_validateString(name))")

        case let .clipNote(startBeat, duration, volume, location, clipStart, clipRate, instrument):
            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(clipStart) \(clipRate) \(_validateString(instrument))")

        case let .comment(text):
            buffer.append("!")
            buffer.append(text)
            buffer.append("\n")

        case let .compressLine(startBeat, duration, maxRatio):
            _writeSection("Compress")
            _writeLine("\(startBeat) \(duration) \(maxRatio)")

        case .end:
            _writeSection("End")

        case .exclude:
            _writeSection("Exclude")

        case let .filterLine(startBeat, duration, filterType, initialPitch, finalPitch, initialBandwidth, finalBandwidth):
            _writeSection("Filter")
            _writeLine("\(startBeat) \(duration) \(filterType.rawValue) \(initialPitch) \(finalPitch) \(initialBandwidth) \(finalBandwidth)")

        case let .flangeLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            _writeSection("Flange")
            _writeLine("\(startBeat) \(duration) \(numberOfVoices) \(depth) \(flipChannels ? 1 : 0)")

        case let .freqBandAnalyzeLine(startBeat, duration, channel, buffer):
            _writeSection("FBA")
            _writeLine("\(startBeat) \(duration) \(channel.rawValue) \(buffer.rawValue)")

        case let .geqLine(beat, bandGains):
            _writeSection("GEQ")

            let gains = bandGains.map { "\($0)" }.joined(separator: " ")

            if gains.isEmpty {
                _writeLine("\(beat)")
            } else {
                _writeLine("\(beat) \(gains)")
            }

        case let .haas(enabled, minDelay, maxDelay, reverbSend):
            _writeSection("Haas")
            _writeLine("\(enabled ? 1 : 0) \(minDelay) \(maxDelay) \(reverbSend ? 1 : 0)")

        case let .include(fileName):
            _writeSection("Include")
            try _writeLine(_validateString(fileName))

        case let .levelsLine(startBeat, duration, startGainLossdB, endGainLossdB):
            _writeSection("Levels")
            _writeLine("\(startBeat) \(duration) \(startGainLossdB) \(endGainLossdB)")

        case let .mixLine(startBeat, duration, gainLossdB, keepSoundBuffer, sign, timeOffset):
            _writeSection("Mix")
            _writeLine("\(startBeat) \(duration) \(gainLossdB) \(keepSoundBuffer ? 1 : 0) \(sign) \(timeOffset)")

        case let .pitchesNote(startBeat, duration, volume, location, startPitch, endPitch, instrument):
            _writeSection("Pitches")

            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(startPitch) \(endPitch) \(_validateString(instrument))")

        case let .pulseLine(startBeat, channel):
            _writeSection("Pulse")
            _writeLine("\(startBeat) \(channel.rawValue)")

        case let .reverbLine(startBeat, duration, direction, size, reverbTime, combFilterDryGain, xTalkFactor, wetness):
            _writeSection("Reverb")
            _writeLine("\(startBeat) \(duration) \(direction.rawValue) \(size.rawValue)"
                       + " \(reverbTime) \(combFilterDryGain) \(xTalkFactor) \(wetness)")

        case let .screenOut(level):
            _writeSection("ScreenOut")
            _writeLine("\(level.rawValue)")

        case let .sendBackLine(startBeat, duration, gainLossdB):
            _writeSection("SendBack")
            _writeLine("\(startBeat) \(duration) \(gainLossdB)")

        case let .showBufferLine(startBeat, duration):
            _writeSection("ShowBuffer")
            _writeLine("\(startBeat) \(duration)")

        case let .soundFileName(name):
            _writeSection("SFN")

            try _writeLine(_validateString(name))

        case let .statsLine(startBeat, duration):
            _writeSection("Stats")
            _writeLine("\(startBeat) \(duration)")

        case let .tempoLine(startBeat, duration, initialTempo, finalTempo):
            _writeSection("Tempo")
            _writeLine("\(startBeat) \(duration) \(initialTempo) \(finalTempo)")

        case let .tuning(primaryInterval, notesPerInterval, pitchConvExponent, pitchConvFactor):
            _writeSection("Tuning")
            _writeLine("\(primaryInterval) \(notesPerInterval) \(pitchConvExponent) \(pitchConvFactor)")

        case let .vocodeMode(channel, name, clipRate, maxHarm, slope, bassBoost, dynExponent, shiftN, peakReduction):
            _writeSection("Vocode",
                          force: true)

            try _writeLine("\(channel.rawValue) \(_validateString(name)) \(clipRate) \(maxHarm)"
                           + " \(slope) \(bassBoost) \(dynExponent) \(shiftN) \(peakReduction)")

        case let .vocodeNote(startBeat, duration, volume, location, pitch, clipStart, instrument):
            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(pitch) \(clipStart) \(_validateString(instrument))")
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
