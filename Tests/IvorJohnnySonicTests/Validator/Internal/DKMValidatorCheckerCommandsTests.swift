// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMValidatorCheckerCommandsTests {
}

// MARK: -

extension DKMValidatorCheckerCommandsTests {
    @Test
    func checkBeat_exceedsTableSize() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkBeat(8_193.0, at: 0)

        #expect(checker.issues == [.beatExceedsTableSize(commandIndex: 0, beat: 8_193.0)])
    }

    @Test
    func checkBeat_withinTableSize() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkBeat(8_192.0, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkChorusLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkChorusLine(DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkClipMode_setsSawClipMode() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkClipMode(DKMClipMode(channel: .left, name: "Drums"), at: 0)

        #expect(checker.issues.isEmpty)
        #expect(checker.sawClipMode)
    }

    @Test
    func checkClipNote_withoutMode() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let note = DKMClipNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Drums")

        checker.checkClipNote(note, at: 0)

        #expect(checker.issues == [.clipNoteWithoutMode(commandIndex: 0)])
    }

    @Test
    func checkCompressLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkCompressLine(DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkFilterLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let line = DKMFilterLine(startBeat: 0.0,
                                 duration: 4.0,
                                 filterType: .butterworthLowpass,
                                 initialPitch: 60.0,
                                 finalPitch: 60.0,
                                 initialBandwidth: 2.0,
                                 finalBandwidth: 2.0)

        checker.checkFilterLine(line, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkFinite_finite() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFinite(1.0, parameter: "value", at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkFinite_nonFinite() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFinite(.nan, parameter: "value", at: 0)

        #expect(checker.issues == [.nonFiniteParameter(commandIndex: 0, parameter: "value")])
    }

    @Test
    func checkFlangeLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFlangeLine(DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkFreqBandAnalyzeLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFreqBandAnalyzeLine(DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkGEQBandGains_exceedsMaximum() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkGEQBandGains(Array(repeating: 0.0, count: 31), at: 0)

        #expect(checker.issues == [.invalidBandGainCount(commandIndex: 0, count: 31)])
    }

    @Test
    func checkGEQBandGains_nonFinite() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkGEQBandGains([.nan], at: 0)

        #expect(checker.issues == [.nonFiniteParameter(commandIndex: 0, parameter: "bandGains")])
    }

    @Test
    func checkGEQLine_incompleteSegment() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkGEQLine(DKMGEQLine(beat: 0.0, bandGains: [0.0]), at: 0, incompleteGEQIndices: [0])

        #expect(checker.issues == [.incompleteGraphicEQSegment(commandIndex: 0)])
    }

    @Test
    func checkGEQLine_validSegment() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkGEQLine(DKMGEQLine(beat: 0.0, bandGains: [0.0]), at: 0, incompleteGEQIndices: [])

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkHaas() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkHaas(DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkInclude_setsSawInclude() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkInclude("Data/Extra.dkm", at: 0)

        #expect(checker.issues.isEmpty)
        #expect(checker.sawInclude)
    }

    @Test
    func checkLevelsLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkLevelsLine(DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkMixLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkMixLine(DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkNoNewlineName_empty() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoNewlineName("", at: 0)

        #expect(checker.issues == [.unwritableName(commandIndex: 0, name: "")])
    }

    @Test
    func checkNoNewlineName_normal() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoNewlineName("Data/Output.aiff", at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkNoNewlineName_withNewline() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoNewlineName("bad\nname", at: 0)

        #expect(checker.issues == [.unwritableName(commandIndex: 0, name: "bad\nname")])
    }

    @Test
    func checkNoWhitespaceName_empty() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoWhitespaceName("", at: 0)

        #expect(checker.issues == [.unwritableName(commandIndex: 0, name: "")])
    }

    @Test
    func checkNoWhitespaceName_normal() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoWhitespaceName("Drums", at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkNoWhitespaceName_withWhitespace() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkNoWhitespaceName("Bad Name", at: 0)

        #expect(checker.issues == [.unwritableName(commandIndex: 0, name: "Bad Name")])
    }

    @Test
    func checkPitchesNote_resetsClipAndVocodeModes() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        checker.sawClipMode = true
        checker.sawVocodeMode = true

        let note = DKMPitchesNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, startPitch: 60.0, endPitch: 60.0, instrument: "Piano")

        checker.checkPitchesNote(note, at: 0)

        #expect(checker.issues.isEmpty)
        #expect(!checker.sawClipMode)
        #expect(!checker.sawVocodeMode)
    }

    @Test
    func checkPositiveDuration_nonPositive() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkPositiveDuration(0.0, at: 0)

        #expect(checker.issues == [.nonPositiveDuration(commandIndex: 0, duration: 0.0)])
    }

    @Test
    func checkPositiveDuration_positive() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkPositiveDuration(1.0, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkPulseLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkPulseLine(DKMPulseLine(startBeat: 0.0, channel: .both), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkReverbLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let line = DKMReverbLine(startBeat: 0.0,
                                 duration: 4.0,
                                 direction: .forward,
                                 size: .medium,
                                 reverbTime: 1.5,
                                 combFilterDryGain: 0.5,
                                 xTalkFactor: 0.3,
                                 wetness: 0.4)

        checker.checkReverbLine(line, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkSegment_beatExceedsTableSize() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkSegment(startBeat: 0.0, duration: 8_193.0, at: 0)

        #expect(checker.issues == [.beatExceedsTableSize(commandIndex: 0, beat: 8_193.0)])
    }

    @Test
    func checkSegment_nonPositiveDuration() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkSegment(startBeat: 0.0, duration: -1.0, at: 0)

        #expect(checker.issues == [.nonPositiveDuration(commandIndex: 0, duration: -1.0)])
    }

    @Test
    func checkSendBackLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkSendBackLine(DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkShowBufferLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkShowBufferLine(DKMShowBufferLine(startBeat: 0.0, duration: 4.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkSoundFileName_withNewline() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkSoundFileName("bad\nname", at: 0)

        #expect(checker.issues == [.unwritableName(commandIndex: 0, name: "bad\nname")])
    }

    @Test
    func checkStatsLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkStatsLine(DKMStatsLine(startBeat: 0.0, duration: 4.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkTempoLine() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkTempoLine(DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 120.0), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkTuning() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkTuning(DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864), at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkVocodeMode_setsSawVocodeMode() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let mode = DKMVocodeMode(channel: .left,
                                 name: "Voice",
                                 clipRate: 1.0,
                                 maxHarm: 0,
                                 slope: 0.0,
                                 bassBoost: 0.0,
                                 dynExponent: 1.0,
                                 shiftN: 0,
                                 peakReduction: 0.0)

        checker.checkVocodeMode(mode, at: 0)

        #expect(checker.issues.isEmpty)
        #expect(checker.sawVocodeMode)
    }

    @Test
    func checkVocodeNote_withoutMode() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let note = DKMVocodeNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.0, instrument: "Voice")

        checker.checkVocodeNote(note, at: 0)

        #expect(checker.issues == [.vocodeNoteWithoutMode(commandIndex: 0)])
    }
}
