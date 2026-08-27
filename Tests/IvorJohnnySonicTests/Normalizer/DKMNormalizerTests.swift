// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMNormalizerTests {
}

// MARK: -

extension DKMNormalizerTests {
    @Test
    func normalize_alreadyNormalized_returnsUnchangedWithNoChanges() {
        let score = DKMScore(commands: [.end],
                             isNormalized: true,
                             isValidated: false)
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes.isEmpty)
        #expect(normalized == score)
        #expect(normalized.isNormalized == true)
    }

    @Test
    func normalize_firstLevelsLineWithContinuation_resolvesToBeatZero() {
        let line = DKMLevelsLine(startBeat: -1.0,
                                 duration: 4.0,
                                 startGainLossdB: 0.0,
                                 endGainLossdB: -6.0)
        let score = DKMScore(commands: [.levelsLine(line)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.resolvedContinuationBeat(commandIndex: 0, startBeat: 0.0)])
        #expect(normalized.commands == [.levelsLine(DKMLevelsLine(startBeat: 0.0,
                                                                  duration: 4.0,
                                                                  startGainLossdB: 0.0,
                                                                  endGainLossdB: -6.0))])
    }

    @Test
    func normalize_negativeFilterStartBeat_isClamped() {
        let line = DKMFilterLine(startBeat: -2.0,
                                 duration: 4.0,
                                 filterType: .butterworthLowpass,
                                 initialPitch: 48.0,
                                 finalPitch: 72.0,
                                 initialBandwidth: 2.0,
                                 finalBandwidth: 2.0)
        let score = DKMScore(commands: [.filterLine(line)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.clampedNegativeStartBeat(commandIndex: 0, startBeat: -2.0)])
        #expect(normalized.commands == [.filterLine(DKMFilterLine(startBeat: 0.0,
                                                                  duration: 4.0,
                                                                  filterType: .butterworthLowpass,
                                                                  initialPitch: 48.0,
                                                                  finalPitch: 72.0,
                                                                  initialBandwidth: 2.0,
                                                                  finalBandwidth: 2.0))])
    }

    @Test
    func normalize_negativeNoteStartBeat_isNotClamped() {
        let note = DKMPitchesNote(startBeat: -5.0,
                                  duration: 1.0,
                                  volume: 1.0,
                                  location: 0.0,
                                  startPitch: 60.0,
                                  endPitch: 60.0,
                                  instrument: "Vanilla")
        let score = DKMScore(commands: [.pitchesNote(note)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes.isEmpty)
        #expect(normalized.commands == [.pitchesNote(note)])
    }

    @Test
    func normalize_normalizedTwice_isIdempotent() throws {
        let data = try loadFixture("AllCommands", extension: "dkm")
        let (score, _) = try DKMParser().parse(data)
        let (once, _) = DKMNormalizer().normalize(score)
        let (twice, changes) = DKMNormalizer().normalize(once)

        #expect(twice == once)
        #expect(changes.isEmpty)
    }

    @Test
    func normalize_redundantHaas_isDropped() {
        let haas = DKMHaas(enabled: true, minDelay: 2.0, maxDelay: 30.0, reverbSend: true)
        let otherHaas = DKMHaas(enabled: true, minDelay: 5.0, maxDelay: 30.0, reverbSend: true)
        let score = DKMScore(commands: [.haas(haas), .haas(haas), .haas(otherHaas)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.droppedRedundantHaas(commandIndex: 1)])
        #expect(normalized.commands == [.haas(haas), .haas(otherHaas)])
    }

    @Test
    func normalize_redundantScreenOut_isDropped() {
        let score = DKMScore(commands: [.screenOut(.verbose), .screenOut(.verbose), .screenOut(.quiet)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.droppedRedundantScreenOut(commandIndex: 1)])
        #expect(normalized.commands == [.screenOut(.verbose), .screenOut(.quiet)])
    }

    @Test
    func normalize_redundantSoundFileName_isDropped() {
        let score = DKMScore(commands: [.soundFileName("Out.AIFF"), .soundFileName("Out.AIFF"), .soundFileName("Other.AIFF")])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.droppedRedundantSoundFileName(commandIndex: 1)])
        #expect(normalized.commands == [.soundFileName("Out.AIFF"), .soundFileName("Other.AIFF")])
    }

    @Test
    func normalize_redundantTuning_isDropped() {
        let tuning = DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)
        let otherTuning = DKMTuning(primaryInterval: 2.0, notesPerInterval: 24.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)
        let score = DKMScore(commands: [.tuning(tuning), .tuning(tuning), .tuning(otherTuning)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.droppedRedundantTuning(commandIndex: 1)])
        #expect(normalized.commands == [.tuning(tuning), .tuning(otherTuning)])
    }

    @Test
    func normalize_secondLevelsLineWithContinuation_resolvesToPreviousEndBeat() {
        let first = DKMLevelsLine(startBeat: 0.0,
                                  duration: 4.0,
                                  startGainLossdB: 0.0,
                                  endGainLossdB: -6.0)
        let second = DKMLevelsLine(startBeat: -1.0,
                                   duration: 4.0,
                                   startGainLossdB: -6.0,
                                   endGainLossdB: 0.0)
        let score = DKMScore(commands: [.levelsLine(first), .levelsLine(second)])
        let (normalized, changes) = DKMNormalizer().normalize(score)

        #expect(changes == [.resolvedContinuationBeat(commandIndex: 1, startBeat: 4.0)])
        #expect(normalized.commands[1] == .levelsLine(DKMLevelsLine(startBeat: 4.0,
                                                                    duration: 4.0,
                                                                    startGainLossdB: -6.0,
                                                                    endGainLossdB: 0.0)))
    }

    @Test
    func normalize_setsIsNormalizedAndClearsIsValidated() {
        let score = DKMScore(commands: [.end],
                             isNormalized: false,
                             isValidated: true)
        let (normalized, _) = DKMNormalizer().normalize(score)

        #expect(normalized.isNormalized == true)
        #expect(normalized.isValidated == false)
    }
}
