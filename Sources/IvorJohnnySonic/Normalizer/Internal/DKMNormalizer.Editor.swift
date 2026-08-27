// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMNormalizer {

    // MARK: Internal Nested Types

    internal struct Editor {

        // MARK: Internal Initializers

        internal init(score: DKMScore) {
            self.changes = []
            self.currentHaas = nil
            self.currentScreenLevel = nil
            self.currentSoundFileName = nil
            self.currentTuning = nil
            self.levelsEndBeat = 0
            self.score = score
        }

        // MARK: Private Instance Properties

        private let score: DKMScore

        private var changes: [Change]
        private var currentHaas: DKMHaas?
        private var currentScreenLevel: DKMScreenLevel?
        private var currentSoundFileName: String?
        private var currentTuning: DKMTuning?
        private var levelsEndBeat: Double
    }
}

// MARK: -

extension DKMNormalizer.Editor {

    // MARK: Internal Instance Methods

    internal mutating func editScore() -> (DKMScore, [DKMNormalizer.Change]) {
        let commands = score.commands.enumerated().compactMap { index, command in
            _editCommand(command, at: index)
        }

        let normalized = DKMScore(commands: commands,
                                  isNormalized: true,
                                  isValidated: false)

        return (normalized, changes)
    }

    // MARK: Private Instance Methods

    private mutating func _clampedDuration(_ duration: Double,
                                           at index: Int) -> Double {
        guard duration < 0
        else { return duration }

        changes.append(.clampedNegativeDuration(commandIndex: index, duration: duration))

        return 0
    }

    private mutating func _clampedStartBeat(_ startBeat: Double,
                                            at index: Int) -> Double {
        guard startBeat < 0
        else { return startBeat }

        changes.append(.clampedNegativeStartBeat(commandIndex: index, startBeat: startBeat))

        return 0
    }

    private mutating func _editCommand(_ command: DKMCommand,
                                       at index: Int) -> DKMCommand? {
        switch command {
        case let .chorusLine(line):
            .chorusLine(DKMChorusLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                      duration: _clampedDuration(line.duration, at: index),
                                      numberOfVoices: line.numberOfVoices,
                                      depth: line.depth,
                                      flipChannels: line.flipChannels))

        case .clipMode:
            command

        case .clipNote:
            command

        case .comment:
            command

        case let .compressLine(line):
            .compressLine(DKMCompressLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                          duration: _clampedDuration(line.duration, at: index),
                                          maxRatio: line.maxRatio))

        case .dynamics:
            command

        case .end:
            command

        case .exclude:
            command

        case let .filterLine(line):
            .filterLine(DKMFilterLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                      duration: _clampedDuration(line.duration, at: index),
                                      filterType: line.filterType,
                                      initialPitch: line.initialPitch,
                                      finalPitch: line.finalPitch,
                                      initialBandwidth: line.initialBandwidth,
                                      finalBandwidth: line.finalBandwidth))

        case let .flangeLine(line):
            .flangeLine(DKMFlangeLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                      duration: _clampedDuration(line.duration, at: index),
                                      numberOfVoices: line.numberOfVoices,
                                      depth: line.depth,
                                      flipChannels: line.flipChannels))

        case let .freqBandAnalyzeLine(line):
            .freqBandAnalyzeLine(DKMFreqBandAnalyzeLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                                        duration: _clampedDuration(line.duration, at: index),
                                                        channel: line.channel,
                                                        buffer: line.buffer))

        case let .geqLine(line):
            .geqLine(DKMGEQLine(beat: _clampedStartBeat(line.beat, at: index),
                                bandGains: line.bandGains))

        case let .haas(haas):
            _editHaas(haas, at: index)

        case .include:
            command

        case let .levelsLine(line):
            .levelsLine(_editLevelsLine(line, at: index))

        case let .mixLine(line):
            .mixLine(DKMMixLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                duration: _clampedDuration(line.duration, at: index),
                                gainLossdB: line.gainLossdB,
                                keepSoundBuffer: line.keepSoundBuffer,
                                sign: line.sign,
                                timeOffset: line.timeOffset))

        case .pitchesNote:
            command

        case let .pulseLine(line):
            .pulseLine(DKMPulseLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                    channel: line.channel))

        case let .reverbLine(line):
            .reverbLine(DKMReverbLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                      duration: _clampedDuration(line.duration, at: index),
                                      direction: line.direction,
                                      size: line.size,
                                      reverbTime: line.reverbTime,
                                      combFilterDryGain: line.combFilterDryGain,
                                      xTalkFactor: line.xTalkFactor,
                                      wetness: line.wetness))

        case let .screenOut(level):
            _editScreenOut(level, at: index)

        case let .sendBackLine(line):
            .sendBackLine(DKMSendBackLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                          duration: _clampedDuration(line.duration, at: index),
                                          gainLossdB: line.gainLossdB))

        case let .showBufferLine(line):
            .showBufferLine(DKMShowBufferLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                              duration: _clampedDuration(line.duration, at: index)))

        case let .soundFileName(name):
            _editSoundFileName(name, at: index)

        case let .statsLine(line):
            .statsLine(DKMStatsLine(startBeat: _clampedStartBeat(line.startBeat, at: index),
                                    duration: _clampedDuration(line.duration, at: index)))

        case .tempoLine:
            command

        case let .tuning(tuning):
            _editTuning(tuning, at: index)

        case .vocodeMode:
            command

        case .vocodeNote:
            command
        }
    }

    private mutating func _editHaas(_ haas: DKMHaas,
                                    at index: Int) -> DKMCommand? {
        guard haas != currentHaas
        else {
            changes.append(.droppedRedundantHaas(commandIndex: index))

            return nil
        }

        currentHaas = haas

        return .haas(haas)
    }

    private mutating func _editLevelsLine(_ line: DKMLevelsLine,
                                          at index: Int) -> DKMLevelsLine {
        let duration = _clampedDuration(line.duration, at: index)
        let startBeat: Double

        if line.startBeat < 0 {
            startBeat = levelsEndBeat

            changes.append(.resolvedContinuationBeat(commandIndex: index, startBeat: startBeat))
        } else {
            startBeat = line.startBeat
        }

        levelsEndBeat = startBeat + duration

        return DKMLevelsLine(startBeat: startBeat,
                             duration: duration,
                             startGainLossdB: line.startGainLossdB,
                             endGainLossdB: line.endGainLossdB)
    }

    private mutating func _editScreenOut(_ level: DKMScreenLevel,
                                         at index: Int) -> DKMCommand? {
        guard level != currentScreenLevel
        else {
            changes.append(.droppedRedundantScreenOut(commandIndex: index))

            return nil
        }

        currentScreenLevel = level

        return .screenOut(level)
    }

    private mutating func _editSoundFileName(_ name: String,
                                             at index: Int) -> DKMCommand? {
        guard name != currentSoundFileName
        else {
            changes.append(.droppedRedundantSoundFileName(commandIndex: index))

            return nil
        }

        currentSoundFileName = name

        return .soundFileName(name)
    }

    private mutating func _editTuning(_ tuning: DKMTuning,
                                      at index: Int) -> DKMCommand? {
        guard tuning != currentTuning
        else {
            changes.append(.droppedRedundantTuning(commandIndex: index))

            return nil
        }

        currentTuning = tuning

        return .tuning(tuning)
    }
}
