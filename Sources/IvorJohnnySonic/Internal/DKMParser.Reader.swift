// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMParser {

    // MARK: Internal Nested Types

    internal struct Reader {

        // MARK: Internal Initializers

        internal init(lines: [Substring]) {
            self.clipModeExpected = false
            self.currentLineNumber = 0
            self.currentSection = nil
            self.lines = lines
            self.vocodeModeExpected = false
        }

        // MARK: Private Instance Properties

        private let lines: [Substring]

        private var clipModeExpected: Bool
        private var currentLineNumber: Int
        private var currentSection: String?
        private var vocodeModeExpected: Bool
    }
}

// MARK: -

extension DKMParser.Reader {

    // MARK: Internal Instance Methods

    internal mutating func readScore() throws -> DKMScore {
        var commands: [DKMCommand] = []

        for (index, line) in lines.enumerated() {
            currentLineNumber = index + 1

            guard !line.allSatisfy(\.isWhitespace)
            else { continue }

            if line.hasPrefix("!") {
                commands.append(.comment(String(line.dropFirst())))
            } else if line.hasPrefix("/") {
                if let command = try _parseCommand(String(line.dropFirst())) {
                    commands.append(command)
                }
            } else {
                try commands.append(_parseDataLine(line))
            }
        }

        return DKMScore(commands: commands)
    }

    // MARK: Private Type Methods

    private static let sectionPrefixes: [String: String] = ["CHO": "Chorus",
                                                            "CLI": "Clip",
                                                            "COM": "Compress",
                                                            "END": "End",
                                                            "EXC": "Exclude",
                                                            "FBA": "FBA",
                                                            "FIL": "Filter",
                                                            "FLA": "Flange",
                                                            "GEQ": "GEQ",
                                                            "HAA": "Haas",
                                                            "INC": "Include",
                                                            "LEV": "Levels",
                                                            "MIX": "Mix",
                                                            "PIT": "Pitches",
                                                            "PUL": "Pulse",
                                                            "REV": "Reverb",
                                                            "SCR": "ScreenOut",
                                                            "SEN": "SendBack",
                                                            "SFN": "SFN",
                                                            "SHO": "ShowBuffer",
                                                            "STA": "Stats",
                                                            "TEM": "Tempo",
                                                            "TUN": "Tuning",
                                                            "VOC": "Vocode"]

    // MARK: Private Instance Methods

    private mutating func _parseDataLine(_ line: Substring) throws -> DKMCommand {
        guard let section = currentSection
        else { throw DKMParseError.unexpectedDataLine(currentLineNumber) }

        switch section {
        case "Chorus":
            return try _parseChorusLine(line)

        case "Clip":
            if clipModeExpected {
                clipModeExpected = false

                return try _parseClipMode(line)
            } else {
                return try _parseClipNote(line)
            }

        case "Compress":
            return try _parseCompressLine(line)

        case "FBA":
            return try _parseFBALine(line)

        case "Filter":
            return try _parseFilterLine(line)

        case "Flange":
            return try _parseFlangeLine(line)

        case "GEQ":
            return try _parseGEQLine(line)

        case "Haas":
            return try _parseHaas(line)

        case "Include":
            return .include(String(line))

        case "Levels":
            return try _parseLevelsLine(line)

        case "Mix":
            return try _parseMixLine(line)

        case "Pitches":
            return try _parsePitchesNote(line)

        case "Pulse":
            return try _parsePulseLine(line)

        case "Reverb":
            return try _parseReverbLine(line)

        case "ScreenOut":
            return try _parseScreenOut(line)

        case "SendBack":
            return try _parseSendBackLine(line)

        case "SFN":
            return .soundFileName(String(line))

        case "ShowBuffer":
            return try _parseShowBufferLine(line)

        case "Stats":
            return try _parseStatsLine(line)

        case "Tempo":
            return try _parseTempoLine(line)

        case "Tuning":
            return try _parseTuning(line)

        case "Vocode":
            if vocodeModeExpected {
                vocodeModeExpected = false

                return try _parseVocodeMode(line)
            } else {
                return try _parseVocodeNote(line)
            }

        default:
            throw DKMParseError.unexpectedDataLine(currentLineNumber)
        }
    }

    private func _parseChorusLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 5)

        return try .chorusLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               numberOfVoices: _parseParameter(tokens[2], "numberOfVoices", parseInt),
                               depth: _parseParameter(tokens[3], "depth", parseDouble),
                               flipChannels: _parseParameter(tokens[4], "flipChannels", parseBool))
    }

    private func _parseClipMode(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 2)

        return try .clipMode(channel: _parseParameter(tokens[0], "channel", parseClipChannel),
                             name: _parseParameter(tokens[1], "name", parseString))
    }

    private func _parseClipNote(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 7)

        return try .clipNote(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                             duration: _parseParameter(tokens[1], "duration", parseDouble),
                             volume: _parseParameter(tokens[2], "volume", parseDouble),
                             location: _parseParameter(tokens[3], "location", parseDouble),
                             clipStart: _parseParameter(tokens[4], "clipStart", parseDouble),
                             clipRate: _parseParameter(tokens[5], "clipRate", parseDouble),
                             instrument: _parseParameter(tokens[6], "instrument", parseString))
    }

    private mutating func _parseCommand(_ section: String) throws -> DKMCommand? {
        let prefix = String(section.prefix(3)).uppercased()

        guard let canonical = Self.sectionPrefixes[prefix]
        else { throw DKMParseError.invalidSection(currentLineNumber, section) }

        switch canonical {
        case "Clip":
            clipModeExpected = true
            currentSection = canonical

        case "End":
            currentSection = nil

            return .end

        case "Exclude":
            currentSection = nil

            return .exclude

        case "Vocode":
            currentSection = canonical
            vocodeModeExpected = true

        default:
            currentSection = canonical
        }

        return nil
    }

    private func _parseCompressLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 3)

        return try .compressLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                                 duration: _parseParameter(tokens[1], "duration", parseDouble),
                                 maxRatio: _parseParameter(tokens[2], "maxRatio", parseDouble))
    }

    private func _parseFBALine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 4)

        return try .freqBandAnalyzeLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                                        duration: _parseParameter(tokens[1], "duration", parseDouble),
                                        channel: _parseParameter(tokens[2], "channel", parseFBAChannel),
                                        buffer: _parseParameter(tokens[3], "buffer", parseFBABuffer))
    }

    private func _parseFilterLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 7)

        return try .filterLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               filterType: _parseParameter(tokens[2], "filterType", parseFilterType),
                               initialPitch: _parseParameter(tokens[3], "initialPitch", parseDouble),
                               finalPitch: _parseParameter(tokens[4], "finalPitch", parseDouble),
                               initialBandwidth: _parseParameter(tokens[5], "initialBandwidth", parseDouble),
                               finalBandwidth: _parseParameter(tokens[6], "finalBandwidth", parseDouble))
    }

    private func _parseFlangeLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 5)

        return try .flangeLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               numberOfVoices: _parseParameter(tokens[2], "numberOfVoices", parseInt),
                               depth: _parseParameter(tokens[3], "depth", parseDouble),
                               flipChannels: _parseParameter(tokens[4], "flipChannels", parseBool))
    }

    private func _parseGEQLine(_ line: Substring) throws -> DKMCommand {
        let tokens = _tokenize(line)

        guard !tokens.isEmpty
        else { throw DKMParseError.invalidParameterCount(currentLineNumber, 1, 0) }

        let beat = try _parseParameter(tokens[0], "beat", parseDouble)

        var bandGains: [Double] = []

        for (index, token) in tokens.dropFirst().enumerated() {
            try bandGains.append(_parseParameter(token, "bandGains[\(index)]", parseDouble))
        }

        return .geqLine(beat: beat, bandGains: bandGains)
    }

    private func _parseHaas(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 4)

        return try .haas(enabled: _parseParameter(tokens[0], "enabled", parseBool),
                         minDelay: _parseParameter(tokens[1], "minDelay", parseDouble),
                         maxDelay: _parseParameter(tokens[2], "maxDelay", parseDouble),
                         reverbSend: _parseParameter(tokens[3], "reverbSend", parseBool))
    }

    private func _parseLevelsLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 4)

        return try .levelsLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               startGainLossdB: _parseParameter(tokens[2], "startGainLossdB", parseDouble),
                               endGainLossdB: _parseParameter(tokens[3], "endGainLossdB", parseDouble))
    }

    private func _parseMixLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 6)

        return try .mixLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                            duration: _parseParameter(tokens[1], "duration", parseDouble),
                            gainLossdB: _parseParameter(tokens[2], "gainLossdB", parseDouble),
                            keepSoundBuffer: _parseParameter(tokens[3], "keepSoundBuffer", parseBool),
                            sign: _parseParameter(tokens[4], "sign", parseDouble),
                            timeOffset: _parseParameter(tokens[5], "timeOffset", parseDouble))
    }

    private func _parseParameter<T>(_ input: Substring,
                                    _ parameterName: String,
                                    _ transform: (Substring) -> T?) throws -> T {
        guard let value = transform(input)
        else { throw DKMParseError.invalidParameterValue(currentLineNumber, parameterName, input) }

        return value
    }

    private func _parsePitchesNote(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 7)

        return try .pitchesNote(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                                duration: _parseParameter(tokens[1], "duration", parseDouble),
                                volume: _parseParameter(tokens[2], "volume", parseDouble),
                                location: _parseParameter(tokens[3], "location", parseDouble),
                                startPitch: _parseParameter(tokens[4], "startPitch", parseDouble),
                                endPitch: _parseParameter(tokens[5], "endPitch", parseDouble),
                                instrument: _parseParameter(tokens[6], "instrument", parseString))
    }

    private func _parsePulseLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 2)

        return try .pulseLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                              channel: _parseParameter(tokens[1], "channel", parseChannel))
    }

    private func _parseReverbLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 8)

        return try .reverbLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               direction: _parseParameter(tokens[2], "direction", parseReverbDirection),
                               size: _parseParameter(tokens[3], "size", parseReverbSize),
                               reverbTime: _parseParameter(tokens[4], "reverbTime", parseDouble),
                               combFilterDryGain: _parseParameter(tokens[5], "combFilterDryGain", parseDouble),
                               xTalkFactor: _parseParameter(tokens[6], "xTalkFactor", parseDouble),
                               wetness: _parseParameter(tokens[7], "wetness", parseDouble))
    }

    private func _parseScreenOut(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 1)

        return try .screenOut(_parseParameter(tokens[0], "level", parseScreenLevel))
    }

    private func _parseSendBackLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 3)

        return try .sendBackLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                                 duration: _parseParameter(tokens[1], "duration", parseDouble),
                                 gainLossdB: _parseParameter(tokens[2], "gainLossdB", parseDouble))
    }

    private func _parseShowBufferLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 2)

        return try .showBufferLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                                   duration: _parseParameter(tokens[1], "duration", parseDouble))
    }

    private func _parseStatsLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 2)

        return try .statsLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                              duration: _parseParameter(tokens[1], "duration", parseDouble))
    }

    private func _parseTempoLine(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 4)

        return try .tempoLine(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                              duration: _parseParameter(tokens[1], "duration", parseDouble),
                              initialTempo: _parseParameter(tokens[2], "initialTempo", parseDouble),
                              finalTempo: _parseParameter(tokens[3], "finalTempo", parseDouble))
    }

    private func _parseTuning(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 4)

        return try .tuning(primaryInterval: _parseParameter(tokens[0], "primaryInterval", parseDouble),
                           notesPerInterval: _parseParameter(tokens[1], "notesPerInterval", parseDouble),
                           pitchConvExponent: _parseParameter(tokens[2], "pitchConvExponent", parseDouble),
                           pitchConvFactor: _parseParameter(tokens[3], "pitchConvFactor", parseDouble))
    }

    private func _parseVocodeMode(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 9)

        return try .vocodeMode(channel: _parseParameter(tokens[0], "channel", parseClipChannel),
                               name: _parseParameter(tokens[1], "name", parseString),
                               clipRate: _parseParameter(tokens[2], "clipRate", parseDouble),
                               maxHarm: _parseParameter(tokens[3], "maxHarm", parseInt),
                               slope: _parseParameter(tokens[4], "slope", parseDouble),
                               bassBoost: _parseParameter(tokens[5], "bassBoost", parseDouble),
                               dynExponent: _parseParameter(tokens[6], "dynExponent", parseDouble),
                               shiftN: _parseParameter(tokens[7], "shiftN", parseInt),
                               peakReduction: _parseParameter(tokens[8], "peakReduction", parseDouble))
    }

    private func _parseVocodeNote(_ line: Substring) throws -> DKMCommand {
        let tokens = try _tokenize(line, 7)

        return try .vocodeNote(startBeat: _parseParameter(tokens[0], "startBeat", parseDouble),
                               duration: _parseParameter(tokens[1], "duration", parseDouble),
                               volume: _parseParameter(tokens[2], "volume", parseDouble),
                               location: _parseParameter(tokens[3], "location", parseDouble),
                               pitch: _parseParameter(tokens[4], "pitch", parseDouble),
                               clipStart: _parseParameter(tokens[5], "clipStart", parseDouble),
                               instrument: _parseParameter(tokens[6], "instrument", parseString))
    }

    private func _tokenize(_ line: Substring) -> [Substring] {
        line.split(separator: " ",
                   omittingEmptySubsequences: true)
    }

    private func _tokenize(_ line: Substring,
                           _ requiredCount: Int) throws -> [Substring] {
        let tokens = _tokenize(line)

        guard tokens.count == requiredCount
        else { throw DKMParseError.invalidParameterCount(currentLineNumber, requiredCount, tokens.count) }

        return tokens
    }
}
