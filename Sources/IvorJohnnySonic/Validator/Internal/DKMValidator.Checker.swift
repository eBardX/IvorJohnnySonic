// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMValidator {

    // MARK: Internal Nested Types

    internal struct Checker {

        // MARK: Internal Initializers

        internal init(score: DKMScore) {
            self.issues = []
            self.sawClipMode = false
            self.sawInclude = false
            self.sawVocodeMode = false
            self.score = score
        }

        // MARK: Internal Instance Properties

        // Shared with DKMValidator.Checker+Bounds.swift and
        // DKMValidator.Checker+Commands.swift.
        internal var issues: [Issue]
        internal var sawClipMode: Bool
        internal var sawInclude: Bool
        internal var sawVocodeMode: Bool

        // MARK: Private Instance Properties

        private let score: DKMScore
    }
}

// MARK: -

extension DKMValidator.Checker {

    // MARK: Internal Instance Methods

    internal mutating func checkScore() -> [DKMValidator.Issue] {
        let incompleteGEQIndices = _incompleteGEQIndices()

        for (index, command) in score.commands.enumerated() {
            _checkCommand(command, at: index, incompleteGEQIndices: incompleteGEQIndices)
        }

        return issues
    }

    // MARK: Private Instance Methods

    private mutating func _checkCommand(_ command: DKMCommand,
                                        at index: Int,
                                        incompleteGEQIndices: Set<Int>) {
        switch command {
        case let .chorusLine(line):
            checkChorusLine(line, at: index)

        case let .clipMode(mode):
            checkClipMode(mode, at: index)

        case let .clipNote(note):
            checkClipNote(note, at: index)

        case .comment:
            break

        case let .compressLine(line):
            checkCompressLine(line, at: index)

        case .dynamics:
            break

        case .end:
            break

        case .exclude:
            break

        case let .filterLine(line):
            checkFilterLine(line, at: index)

        case let .flangeLine(line):
            checkFlangeLine(line, at: index)

        case let .freqBandAnalyzeLine(line):
            checkFreqBandAnalyzeLine(line, at: index)

        case let .geqLine(line):
            checkGEQLine(line, at: index, incompleteGEQIndices: incompleteGEQIndices)

        case let .haas(haas):
            checkHaas(haas, at: index)

        case let .include(fileName):
            checkInclude(fileName, at: index)

        case let .levelsLine(line):
            checkLevelsLine(line, at: index)

        case let .mixLine(line):
            checkMixLine(line, at: index)

        case let .pitchesNote(note):
            checkPitchesNote(note, at: index)

        case let .pulseLine(line):
            checkPulseLine(line, at: index)

        case let .reverbLine(line):
            checkReverbLine(line, at: index)

        case .screenOut:
            break

        case let .sendBackLine(line):
            checkSendBackLine(line, at: index)

        case let .showBufferLine(line):
            checkShowBufferLine(line, at: index)

        case let .soundFileName(name):
            checkSoundFileName(name, at: index)

        case let .statsLine(line):
            checkStatsLine(line, at: index)

        case let .tempoLine(line):
            checkTempoLine(line, at: index)

        case let .tuning(tuning):
            checkTuning(tuning, at: index)

        case let .vocodeMode(mode):
            checkVocodeMode(mode, at: index)

        case let .vocodeNote(note):
            checkVocodeNote(note, at: index)
        }
    }

    // Walks maximal runs of consecutive `.geqLine` commands and returns the
    // index of every run whose length is exactly 1 — the C interpolates
    // between consecutive segments, so a lone line has a start and no end
    // (main.c: ProcessGEQ line 1841).
    private func _incompleteGEQIndices() -> Set<Int> {
        var indices: Set<Int> = []
        var runStart: Int?

        for (index, command) in score.commands.enumerated() {
            if case .geqLine = command {
                if runStart == nil {
                    runStart = index
                }
            } else {
                if let start = runStart, start == index - 1 {
                    indices.insert(start)
                }

                runStart = nil
            }
        }

        if let start = runStart, start == score.commands.count - 1 {
            indices.insert(start)
        }

        return indices
    }
}
