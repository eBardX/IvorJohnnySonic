// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMValidatorCheckerTests {
}

// MARK: -

extension DKMValidatorCheckerTests {
    @Test
    func checkScore_beatExceedsTableSize_endBeat() {
        let line = DKMShowBufferLine(startBeat: 8_000.0, duration: 200.0)
        let score = DKMScore(commands: [.showBufferLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.beatExceedsTableSize(commandIndex: 0, beat: 8_200.0)])
    }

    @Test
    func checkScore_beatExceedsTableSize_startBeat() {
        let line = DKMPulseLine(startBeat: 9_000.0, channel: .both)
        let score = DKMScore(commands: [.pulseLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.beatExceedsTableSize(commandIndex: 0, beat: 9_000.0)])
    }

    @Test
    func checkScore_cleanScore_noIssues() {
        let score = DKMScore(commands: [.comment("test"), .dynamics, .end])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_clipNoteAfterInclude_noIssue() {
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 1.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.include("Data/Extra.dkm"), .clipNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_clipNoteWithMode_noIssue() {
        let mode = DKMClipMode(channel: .right, name: "Clip")
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 1.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipMode(mode), .clipNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_clipNoteWithoutMode() {
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 1.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.clipNoteWithoutMode(commandIndex: 0)])
    }

    @Test
    func checkScore_completeGraphicEQSegment_noIssue() {
        let line1 = DKMGEQLine(beat: 0.0, bandGains: [0.0])
        let line2 = DKMGEQLine(beat: 4.0, bandGains: [0.0])
        let score = DKMScore(commands: [.geqLine(line1), .geqLine(line2)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_incompleteGraphicEQSegment_lastLineOfScore() {
        let line1 = DKMGEQLine(beat: 0.0, bandGains: [0.0])
        let line2 = DKMGEQLine(beat: 4.0, bandGains: [0.0])
        let line3 = DKMGEQLine(beat: 8.0, bandGains: [0.0])
        let score = DKMScore(commands: [.geqLine(line1), .geqLine(line2), .comment("break"), .geqLine(line3)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.incompleteGraphicEQSegment(commandIndex: 3)])
    }

    @Test
    func checkScore_incompleteGraphicEQSegment_singleLine() {
        let line = DKMGEQLine(beat: 0.0, bandGains: [0.0])
        let score = DKMScore(commands: [.geqLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.incompleteGraphicEQSegment(commandIndex: 0)])
    }

    @Test
    func checkScore_invalidBandGainCount() {
        let line1 = DKMGEQLine(beat: 0.0, bandGains: Array(repeating: 0.0, count: 31))
        let line2 = DKMGEQLine(beat: 4.0, bandGains: [0.0])
        let score = DKMScore(commands: [.geqLine(line1), .geqLine(line2)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.invalidBandGainCount(commandIndex: 0, count: 31)])
    }

    @Test
    func checkScore_multipleIssues_accumulate() {
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 0.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipNote(note)])
        var checker = DKMValidator.Checker(score: score)
        let issues = checker.checkScore()

        #expect(issues.contains(.clipNoteWithoutMode(commandIndex: 0)))
        #expect(issues.contains(.nonPositiveDuration(commandIndex: 0, duration: 0.0)))
        #expect(issues.count == 2)
    }

    @Test
    func checkScore_nonFiniteParameter() {
        let line = DKMShowBufferLine(startBeat: .nan, duration: 1.0)
        let score = DKMScore(commands: [.showBufferLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.nonFiniteParameter(commandIndex: 0, parameter: "startBeat")])
    }

    @Test
    func checkScore_nonPositiveDuration() {
        let line = DKMStatsLine(startBeat: 0.0, duration: -1.0)
        let score = DKMScore(commands: [.statsLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.nonPositiveDuration(commandIndex: 0, duration: -1.0)])
    }

    @Test
    func checkScore_nonPositiveTempo() {
        let line = DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 0.0)
        let score = DKMScore(commands: [.tempoLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.nonPositiveTempo(commandIndex: 0, tempo: 0.0)])
    }

    @Test
    func checkScore_parameterOutOfRange_flangeDepth() {
        let line = DKMFlangeLine(startBeat: 0.0, duration: 1.0, numberOfVoices: 4, depth: 4.0, flipChannels: false)
        let score = DKMScore(commands: [.flangeLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.parameterOutOfRange(commandIndex: 0, parameter: "depth", value: 4.0)])
    }

    @Test
    func checkScore_parameterOutOfRange_haasMinDelay() {
        let haas = DKMHaas(enabled: true, minDelay: 41.0, maxDelay: 50.0, reverbSend: false)
        let score = DKMScore(commands: [.haas(haas)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.parameterOutOfRange(commandIndex: 0, parameter: "minDelay", value: 41.0)])
    }

    @Test
    func checkScore_parameterOutOfRange_reverbWetness() {
        let line = DKMReverbLine(startBeat: 0.0,
                                 duration: 1.0,
                                 direction: .forward,
                                 size: .medium,
                                 reverbTime: 1.0,
                                 combFilterDryGain: 0.5,
                                 xTalkFactor: 0.5,
                                 wetness: 1.5)
        let score = DKMScore(commands: [.reverbLine(line)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.parameterOutOfRange(commandIndex: 0, parameter: "wetness", value: 1.5)])
    }

    @Test
    func checkScore_parameterOutOfRange_tuningPrimaryInterval() {
        let tuning = DKMTuning(primaryInterval: 1.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)
        let score = DKMScore(commands: [.tuning(tuning)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.parameterOutOfRange(commandIndex: 0, parameter: "primaryInterval", value: 1.0)])
    }

    @Test
    func checkScore_parameterOutOfRange_vocodeClipRate() {
        let mode = DKMVocodeMode(channel: .right,
                                 name: "Voc",
                                 clipRate: 0.0,
                                 maxHarm: 0,
                                 slope: 0.0,
                                 bassBoost: 0.0,
                                 dynExponent: 1.0,
                                 shiftN: 0,
                                 peakReduction: 0.0)
        let score = DKMScore(commands: [.vocodeMode(mode)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.parameterOutOfRange(commandIndex: 0, parameter: "clipRate", value: 0.0)])
    }

    @Test
    func checkScore_pitchesNoteClearsClipMode() {
        let mode = DKMClipMode(channel: .right, name: "Clip")
        let pitches = DKMPitchesNote(startBeat: 0.0,
                                     duration: 1.0,
                                     volume: 1.0,
                                     location: 0.0,
                                     startPitch: 60.0,
                                     endPitch: 60.0,
                                     instrument: "Vanilla")
        let note = DKMClipNote(startBeat: 1.0,
                               duration: 1.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipMode(mode), .pitchesNote(pitches), .clipNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.clipNoteWithoutMode(commandIndex: 2)])
    }

    @Test
    func checkScore_unwritableName_instrumentWithWhitespace() {
        let note = DKMPitchesNote(startBeat: 0.0,
                                  duration: 1.0,
                                  volume: 1.0,
                                  location: 0.0,
                                  startPitch: 60.0,
                                  endPitch: 60.0,
                                  instrument: "Bad Name")
        let score = DKMScore(commands: [.pitchesNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.unwritableName(commandIndex: 0, name: "Bad Name")])
    }

    @Test
    func checkScore_unwritableName_soundFileNameWithNewline() {
        let score = DKMScore(commands: [.soundFileName("bad\nname")])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.unwritableName(commandIndex: 0, name: "bad\nname")])
    }

    @Test
    func checkScore_unwritableName_soundFileNameWithSpace_noIssue() {
        // Unlike a note's instrument or a mode's name, a `/SFN` path is
        // permitted to contain spaces — only an empty value or a newline is
        // unwritable.
        let score = DKMScore(commands: [.soundFileName("bad name.aiff")])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_vocodeNoteAfterInclude_noIssue() {
        let note = DKMVocodeNote(startBeat: 0.0,
                                 duration: 1.0,
                                 volume: 1.0,
                                 location: 0.0,
                                 pitch: 60.0,
                                 clipStart: 0.0,
                                 instrument: "Voc")
        let score = DKMScore(commands: [.include("Data/Extra.dkm"), .vocodeNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore().isEmpty)
    }

    @Test
    func checkScore_vocodeNoteWithoutMode() {
        let note = DKMVocodeNote(startBeat: 0.0,
                                 duration: 1.0,
                                 volume: 1.0,
                                 location: 0.0,
                                 pitch: 60.0,
                                 clipStart: 0.0,
                                 instrument: "Voc")
        let score = DKMScore(commands: [.vocodeNote(note)])
        var checker = DKMValidator.Checker(score: score)

        #expect(checker.checkScore() == [.vocodeNoteWithoutMode(commandIndex: 0)])
    }
}
