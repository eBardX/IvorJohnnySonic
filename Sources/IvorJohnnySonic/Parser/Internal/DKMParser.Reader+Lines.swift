// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMParser.Reader {

    // MARK: Internal Instance Methods

    internal mutating func parseChorusLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 5)

        return try .chorusLine(DKMChorusLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             numberOfVoices: parseIntParameter(tokens[2], "numberOfVoices"),
                                             depth: parseParameter(tokens[3], "depth", parseDouble),
                                             flipChannels: parseParameter(tokens[4], "flipChannels", parseBool)))
    }

    internal func parseClipMode(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 2)

        return try .clipMode(DKMClipMode(channel: parseParameter(tokens[0], "channel", parseClipChannel),
                                         name: parseParameter(tokens[1], "name", parseString)))
    }

    internal func parseClipNote(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 7)

        return try .clipNote(DKMClipNote(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                         duration: parseParameter(tokens[1], "duration", parseDouble),
                                         volume: parseParameter(tokens[2], "volume", parseDouble),
                                         location: parseParameter(tokens[3], "location", parseDouble),
                                         clipStart: parseParameter(tokens[4], "clipStart", parseDouble),
                                         clipRate: parseParameter(tokens[5], "clipRate", parseDouble),
                                         instrument: parseParameter(tokens[6], "instrument", parseString)))
    }

    internal func parseCompressLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 3)

        return try .compressLine(DKMCompressLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                                 duration: parseParameter(tokens[1], "duration", parseDouble),
                                                 maxRatio: parseParameter(tokens[2], "maxRatio", parseDouble)))
    }

    internal func parseFBALine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 4)

        return try .freqBandAnalyzeLine(DKMFreqBandAnalyzeLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                                               duration: parseParameter(tokens[1], "duration", parseDouble),
                                                               channel: parseParameter(tokens[2], "channel", parseFBAChannel),
                                                               buffer: parseParameter(tokens[3], "buffer", parseFBABuffer)))
    }

    internal func parseFilterLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 7)

        return try .filterLine(DKMFilterLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             filterType: parseParameter(tokens[2], "filterType", parseFilterType),
                                             initialPitch: parseParameter(tokens[3], "initialPitch", parseDouble),
                                             finalPitch: parseParameter(tokens[4], "finalPitch", parseDouble),
                                             initialBandwidth: parseParameter(tokens[5], "initialBandwidth", parseDouble),
                                             finalBandwidth: parseParameter(tokens[6], "finalBandwidth", parseDouble)))
    }

    internal mutating func parseFlangeLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 5)

        return try .flangeLine(DKMFlangeLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             numberOfVoices: parseIntParameter(tokens[2], "numberOfVoices"),
                                             depth: parseParameter(tokens[3], "depth", parseDouble),
                                             flipChannels: parseParameter(tokens[4], "flipChannels", parseBool)))
    }

    internal mutating func parseGEQLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = tokenize(line)

        guard !tokens.isEmpty
        else { throw DKMParser.Error.invalidParameterCount(currentLineNumber, 1, 0) }

        let beat = try parseParameter(tokens[0], "beat", parseDouble)

        var bandGains: [Double] = []

        for (index, token) in tokens.dropFirst().enumerated() {
            try bandGains.append(parseParameter(token, "bandGains[\(index)]", parseDouble))
        }

        if bandGains.count != 30 {
            diagnostics.append(.bandGainCountMismatch(lineNumber: currentLineNumber, count: bandGains.count))
        }

        return .geqLine(DKMGEQLine(beat: beat, bandGains: bandGains))
    }

    internal func parseHaas(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 4)

        return try .haas(DKMHaas(enabled: parseParameter(tokens[0], "enabled", parseBool),
                                 minDelay: parseParameter(tokens[1], "minDelay", parseDouble),
                                 maxDelay: parseParameter(tokens[2], "maxDelay", parseDouble),
                                 reverbSend: parseParameter(tokens[3], "reverbSend", parseBool)))
    }

    internal func parseLevelsLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 4)

        return try .levelsLine(DKMLevelsLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             startGainLossdB: parseParameter(tokens[2], "startGainLossdB", parseDouble),
                                             endGainLossdB: parseParameter(tokens[3], "endGainLossdB", parseDouble)))
    }

    internal func parseMixLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 6)

        return try .mixLine(DKMMixLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                       duration: parseParameter(tokens[1], "duration", parseDouble),
                                       gainLossdB: parseParameter(tokens[2], "gainLossdB", parseDouble),
                                       keepSoundBuffer: parseParameter(tokens[3], "keepSoundBuffer", parseBool),
                                       sign: parseParameter(tokens[4], "sign", parseDouble),
                                       timeOffset: parseParameter(tokens[5], "timeOffset", parseDouble)))
    }

    internal func parsePitchesNote(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 7)

        return try .pitchesNote(DKMPitchesNote(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                               duration: parseParameter(tokens[1], "duration", parseDouble),
                                               volume: parseParameter(tokens[2], "volume", parseDouble),
                                               location: parseParameter(tokens[3], "location", parseDouble),
                                               startPitch: parseParameter(tokens[4], "startPitch", parseDouble),
                                               endPitch: parseParameter(tokens[5], "endPitch", parseDouble),
                                               instrument: parseParameter(tokens[6], "instrument", parseString)))
    }

    internal func parsePulseLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 2)

        return try .pulseLine(DKMPulseLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                           channel: parseParameter(tokens[1], "channel", parseChannel)))
    }

    internal func parseReverbLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 8)

        return try .reverbLine(DKMReverbLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             direction: parseParameter(tokens[2], "direction", parseReverbDirection),
                                             size: parseParameter(tokens[3], "size", parseReverbSize),
                                             reverbTime: parseParameter(tokens[4], "reverbTime", parseDouble),
                                             combFilterDryGain: parseParameter(tokens[5], "combFilterDryGain", parseDouble),
                                             xTalkFactor: parseParameter(tokens[6], "xTalkFactor", parseDouble),
                                             wetness: parseParameter(tokens[7], "wetness", parseDouble)))
    }

    internal func parseScreenOut(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 1)

        return try .screenOut(parseParameter(tokens[0], "level", parseScreenLevel))
    }

    internal func parseSendBackLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 3)

        return try .sendBackLine(DKMSendBackLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                                 duration: parseParameter(tokens[1], "duration", parseDouble),
                                                 gainLossdB: parseParameter(tokens[2], "gainLossdB", parseDouble)))
    }

    internal func parseShowBufferLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 2)

        return try .showBufferLine(DKMShowBufferLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                                     duration: parseParameter(tokens[1], "duration", parseDouble)))
    }

    internal func parseStatsLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 2)

        return try .statsLine(DKMStatsLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                           duration: parseParameter(tokens[1], "duration", parseDouble)))
    }

    internal func parseTempoLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 4)

        return try .tempoLine(DKMTempoLine(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                           duration: parseParameter(tokens[1], "duration", parseDouble),
                                           initialTempo: parseParameter(tokens[2], "initialTempo", parseDouble),
                                           finalTempo: parseParameter(tokens[3], "finalTempo", parseDouble)))
    }

    internal func parseTuning(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 4)

        return try .tuning(DKMTuning(primaryInterval: parseParameter(tokens[0], "primaryInterval", parseDouble),
                                     notesPerInterval: parseParameter(tokens[1], "notesPerInterval", parseDouble),
                                     pitchConvExponent: parseParameter(tokens[2], "pitchConvExponent", parseDouble),
                                     pitchConvFactor: parseParameter(tokens[3], "pitchConvFactor", parseDouble)))
    }

    internal mutating func parseVocodeMode(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 9)

        return try .vocodeMode(DKMVocodeMode(channel: parseParameter(tokens[0], "channel", parseClipChannel),
                                             name: parseParameter(tokens[1], "name", parseString),
                                             clipRate: parseParameter(tokens[2], "clipRate", parseDouble),
                                             maxHarm: parseIntParameter(tokens[3], "maxHarm"),
                                             slope: parseParameter(tokens[4], "slope", parseDouble),
                                             bassBoost: parseParameter(tokens[5], "bassBoost", parseDouble),
                                             dynExponent: parseParameter(tokens[6], "dynExponent", parseDouble),
                                             shiftN: parseIntParameter(tokens[7], "shiftN"),
                                             peakReduction: parseParameter(tokens[8], "peakReduction", parseDouble)))
    }

    internal func parseVocodeNote(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        let tokens = try tokenize(line, 7)

        return try .vocodeNote(DKMVocodeNote(startBeat: parseParameter(tokens[0], "startBeat", parseDouble),
                                             duration: parseParameter(tokens[1], "duration", parseDouble),
                                             volume: parseParameter(tokens[2], "volume", parseDouble),
                                             location: parseParameter(tokens[3], "location", parseDouble),
                                             pitch: parseParameter(tokens[4], "pitch", parseDouble),
                                             clipStart: parseParameter(tokens[5], "clipStart", parseDouble),
                                             instrument: parseParameter(tokens[6], "instrument", parseString)))
    }
}
