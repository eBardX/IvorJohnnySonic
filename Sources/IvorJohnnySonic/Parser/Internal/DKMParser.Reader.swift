// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMParser {

    // MARK: Internal Nested Types

    internal struct Reader {

        // MARK: Internal Initializers

        internal init(lines: [Substring]) {
            self.clipModeExpected = false
            self.currentLineNumber = 0
            self.currentSection = nil
            self.diagnostics = []
            self.lines = lines
            self.vocodeModeExpected = false
        }

        // MARK: Internal Instance Properties

        internal var currentLineNumber: Int
        internal var diagnostics: [DKMParser.Diagnostic]

        // MARK: Private Instance Properties

        private let lines: [Substring]

        private var clipModeExpected: Bool
        private var currentSection: String?
        private var vocodeModeExpected: Bool
    }
}

// MARK: -

extension DKMParser.Reader {

    // MARK: Internal Instance Methods

    internal mutating func parseIntParameter(_ input: Substring,
                                             _ parameterName: String) throws(DKMParser.Error) -> Int {
        if let intValue = parseInt(input) {
            return intValue
        }

        guard let doubleValue = Double(input),
              doubleValue.isFinite
        else { throw DKMParser.Error.invalidParameterValue(currentLineNumber, parameterName, input) }

        diagnostics.append(.truncatedIntegerParameter(lineNumber: currentLineNumber,
                                                      parameter: parameterName,
                                                      value: doubleValue))

        return Int(doubleValue)
    }

    internal func parseParameter<T>(_ input: Substring,
                                    _ parameterName: String,
                                    _ transform: (Substring) -> T?) throws(DKMParser.Error) -> T {
        guard let value = transform(input)
        else { throw DKMParser.Error.invalidParameterValue(currentLineNumber, parameterName, input) }

        return value
    }

    internal mutating func readScore() throws(DKMParser.Error) -> (DKMScore, [DKMParser.Diagnostic]) {
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

        return (DKMScore(commands: commands), diagnostics)
    }

    internal func tokenize(_ line: Substring) -> [Substring] {
        line.split(separator: " ",
                   omittingEmptySubsequences: true)
    }

    internal func tokenize(_ line: Substring,
                           _ requiredCount: Int) throws(DKMParser.Error) -> [Substring] {
        let tokens = tokenize(line)

        guard tokens.count == requiredCount
        else { throw DKMParser.Error.invalidParameterCount(currentLineNumber, requiredCount, tokens.count) }

        return tokens
    }

    // MARK: Private Type Properties

    private static let sectionPrefixes: [String: String] = ["CHO": "Chorus",
                                                            "CLI": "Clip",
                                                            "COM": "Compress",
                                                            "DYN": "Dynamics",
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

    private mutating func _parseCommand(_ section: String) throws(DKMParser.Error) -> DKMCommand? {
        let prefix = String(section.prefix(3)).uppercased()

        guard let canonical = Self.sectionPrefixes[prefix]
        else { throw DKMParser.Error.invalidSection(currentLineNumber, section) }

        switch canonical {
        case "Clip":
            clipModeExpected = true
            currentSection = canonical

        case "Dynamics":
            currentSection = canonical

            return .dynamics

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

    private mutating func _parseDataLine(_ line: Substring) throws(DKMParser.Error) -> DKMCommand {
        guard let section = currentSection
        else { throw DKMParser.Error.unexpectedDataLine(currentLineNumber) }

        switch section {
        case "Chorus":
            return try parseChorusLine(line)

        case "Clip":
            if clipModeExpected {
                clipModeExpected = false

                return try parseClipMode(line)
            } else {
                return try parseClipNote(line)
            }

        case "Compress":
            return try parseCompressLine(line)

        case "FBA":
            return try parseFBALine(line)

        case "Filter":
            return try parseFilterLine(line)

        case "Flange":
            return try parseFlangeLine(line)

        case "GEQ":
            return try parseGEQLine(line)

        case "Haas":
            return try parseHaas(line)

        case "Include":
            return .include(String(line))

        case "Levels":
            return try parseLevelsLine(line)

        case "Mix":
            return try parseMixLine(line)

        case "Pitches":
            return try parsePitchesNote(line)

        case "Pulse":
            return try parsePulseLine(line)

        case "Reverb":
            return try parseReverbLine(line)

        case "ScreenOut":
            return try parseScreenOut(line)

        case "SendBack":
            return try parseSendBackLine(line)

        case "SFN":
            return .soundFileName(String(line))

        case "ShowBuffer":
            return try parseShowBufferLine(line)

        case "Stats":
            return try parseStatsLine(line)

        case "Tempo":
            return try parseTempoLine(line)

        case "Tuning":
            return try parseTuning(line)

        case "Vocode":
            if vocodeModeExpected {
                vocodeModeExpected = false

                return try parseVocodeMode(line)
            } else {
                return try parseVocodeNote(line)
            }

        default:
            throw DKMParser.Error.unexpectedDataLine(currentLineNumber)
        }
    }
}
