// © 2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

extension DKMFormatter {

    // MARK: Internal Nested Types

    internal struct Writer {

        // MARK: Internal Initializers

        internal init(score: DKMScore) {
            self.buffer = ""
            self.previousHeader = nil
            self.score = score
        }

        // MARK: Private Instance Properties

        private let score: DKMScore

        private var buffer: String
        private var previousHeader: String?
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

    private mutating func _writeCommand(_ command: DKMCommand) throws {
        switch command {
            // MARK: Comment

        case let .comment(text):
            buffer.append("!\(text)\n")

            // MARK: /Chorus

        case let .chorusLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            _writeHeader("Chorus")
            _writeLine("\(startBeat) \(duration) \(numberOfVoices) \(depth) \(flipChannels ? 1 : 0)")

            // MARK: /Clip

        case let .clipMode(channel, name):
            _writeHeader("Clip", force: true)
            try _writeLine("\(channel.rawValue) \(_validateString(name))")

        case let .clipNote(startBeat, duration, volume, location, clipStart, clipRate, instrument):
            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(clipStart) \(clipRate) \(_validateString(instrument))")

            // MARK: /Compress

        case let .compressLine(startBeat, duration, maxRatio):
            _writeHeader("Compress")
            _writeLine("\(startBeat) \(duration) \(maxRatio)")

            // MARK: /End

        case .end:
            _writeHeader("End")

            // MARK: /Exclude

        case .exclude:
            _writeHeader("Exclude")

            // MARK: /FBA

        case let .freqBandAnalyzeLine(startBeat, duration, channel, buffer):
            _writeHeader("FBA")
            _writeLine("\(startBeat) \(duration) \(channel.rawValue) \(buffer.rawValue)")

            // MARK: /Filter

        case let .filterLine(startBeat, duration, filterType, initialPitch, finalPitch, initialBandwidth, finalBandwidth):
            _writeHeader("Filter")
            _writeLine("\(startBeat) \(duration) \(filterType.rawValue) \(initialPitch) \(finalPitch) \(initialBandwidth) \(finalBandwidth)")

            // MARK: /Flange

        case let .flangeLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            _writeHeader("Flange")
            _writeLine("\(startBeat) \(duration) \(numberOfVoices) \(depth) \(flipChannels ? 1 : 0)")

            // MARK: /GEQ

        case let .geqLine(beat, bandGains):
            _writeHeader("GEQ")

            let gains = bandGains.map { "\($0)" }.joined(separator: " ")

            if gains.isEmpty {
                _writeLine("\(beat)")
            } else {
                _writeLine("\(beat) \(gains)")
            }

            // MARK: /Haas

        case let .haas(enabled, minDelay, maxDelay, reverbSend):
            _writeHeader("Haas")
            _writeLine("\(enabled ? 1 : 0) \(minDelay) \(maxDelay) \(reverbSend ? 1 : 0)")

            // MARK: /Include

        case let .include(fileName):
            _writeHeader("Include")
            try _writeLine(_validateString(fileName))

            // MARK: /Levels

        case let .levelsLine(startBeat, duration, startGainLossdB, endGainLossdB):
            _writeHeader("Levels")
            _writeLine("\(startBeat) \(duration) \(startGainLossdB) \(endGainLossdB)")

            // MARK: /Mix

        case let .mixLine(startBeat, duration, gainLossdB, keepSoundBuffer, sign, timeOffset):
            _writeHeader("Mix")
            _writeLine("\(startBeat) \(duration) \(gainLossdB) \(keepSoundBuffer ? 1 : 0) \(sign) \(timeOffset)")

            // MARK: /Pitches

        case let .pitchesNote(startBeat, duration, volume, location, startPitch, endPitch, instrument):
            _writeHeader("Pitches")
            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(startPitch) \(endPitch) \(_validateString(instrument))")

            // MARK: /Pulse

        case let .pulseLine(startBeat, channel):
            _writeHeader("Pulse")
            _writeLine("\(startBeat) \(channel.rawValue)")

            // MARK: /Reverb

        case let .reverbLine(startBeat, duration, direction, size, reverbTime, combFilterDryGain, xTalkFactor, wetness):
            _writeHeader("Reverb")
            _writeLine("\(startBeat) \(duration) \(direction.rawValue) \(size.rawValue)"
                       + " \(reverbTime) \(combFilterDryGain) \(xTalkFactor) \(wetness)")

            // MARK: /ScreenOut

        case let .screenOut(level):
            _writeHeader("ScreenOut")
            _writeLine("\(level.rawValue)")

            // MARK: /SendBack

        case let .sendBackLine(startBeat, duration, gainLossdB):
            _writeHeader("SendBack")
            _writeLine("\(startBeat) \(duration) \(gainLossdB)")

            // MARK: /SFN

        case let .soundFileName(name):
            _writeHeader("SFN")
            try _writeLine(_validateString(name))

            // MARK: /ShowBuffer

        case let .showBufferLine(startBeat, duration):
            _writeHeader("ShowBuffer")
            _writeLine("\(startBeat) \(duration)")

            // MARK: /Stats

        case let .statsLine(startBeat, duration):
            _writeHeader("Stats")
            _writeLine("\(startBeat) \(duration)")

            // MARK: /Tempo

        case let .tempoLine(startBeat, duration, initialTempo, finalTempo):
            _writeHeader("Tempo")
            _writeLine("\(startBeat) \(duration) \(initialTempo) \(finalTempo)")

            // MARK: /Tuning

        case let .tuning(primaryInterval, notesPerInterval, pitchConvExponent, pitchConvFactor):
            _writeHeader("Tuning")
            _writeLine("\(primaryInterval) \(notesPerInterval) \(pitchConvExponent) \(pitchConvFactor)")

            // MARK: /Vocode

        case let .vocodeMode(channel, name, clipRate, maxHarm, slope, bassBoost, dynExponent, shiftN, peakReduction):
            _writeHeader("Vocode", force: true)
            try _writeLine("\(channel.rawValue) \(_validateString(name)) \(clipRate) \(maxHarm)"
                       + " \(slope) \(bassBoost) \(dynExponent) \(shiftN) \(peakReduction)")

        case let .vocodeNote(startBeat, duration, volume, location, pitch, clipStart, instrument):
            try _writeLine("\(startBeat) \(duration) \(volume) \(location) \(pitch) \(clipStart) \(_validateString(instrument))")
        }
    }

    private mutating func _writeHeader(_ header: String,
                                       force: Bool = false) {
        // Writes `/Header\n` when the section changes; always writes when
        // `force` is `true` (used by mode-setting commands such as `/Clip` and
        // `/Vocode` that must restate their header for each new mode block).
        if force || header != previousHeader {
            previousHeader = header

            buffer.append("/\(header)\n")
        }
    }

    private mutating func _writeLine(_ line: String) {
        buffer.append(line)
        buffer.append("\n")
    }

    private func _validateString(_ string: String) throws -> String {
        guard !string.contains(where: \.isNewline)
        else { throw DKMFormatError.invalidStringArgument(string) }

        return string
    }
}
