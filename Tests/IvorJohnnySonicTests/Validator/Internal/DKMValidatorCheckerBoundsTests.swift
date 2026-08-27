// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMValidatorCheckerBoundsTests {
}

// MARK: -

extension DKMValidatorCheckerBoundsTests {
    @Test
    func checkCompressMaxRatio_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkCompressMaxRatio(6.0, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkCompressMaxRatio_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkCompressMaxRatio(1.5, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "maxRatio", value: 1.5)])
    }

    @Test
    func checkFlangeDepth_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFlangeDepth(0.5, numberOfVoices: 4, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkFlangeDepth_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkFlangeDepth(4.0, numberOfVoices: 4, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "depth", value: 4.0)])
    }

    @Test
    func checkHaasDelays_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkHaasDelays(minDelay: 10.0, maxDelay: 40.0, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkHaasDelays_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkHaasDelays(minDelay: -1.0, maxDelay: 100.0, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "minDelay", value: -1.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "maxDelay", value: 100.0)])
    }

    @Test
    func checkReverbParameters_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkReverbParameters(reverbTime: 1.5, combFilterDryGain: 0.5, xTalkFactor: 0.3, wetness: 0.4, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkReverbParameters_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkReverbParameters(reverbTime: -1.0, combFilterDryGain: 2.0, xTalkFactor: -1.0, wetness: 2.0, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "reverbTime", value: -1.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "combFilterDryGain", value: 2.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "xTalkFactor", value: -1.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "wetness", value: 2.0)])
    }

    @Test
    func checkTempoValues_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkTempoValues(initialTempo: 60.0, finalTempo: 120.0, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkTempoValues_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))

        checker.checkTempoValues(initialTempo: 0.0, finalTempo: -1.0, at: 0)

        #expect(checker.issues == [.nonPositiveTempo(commandIndex: 0, tempo: 0.0),
                                   .nonPositiveTempo(commandIndex: 0, tempo: -1.0)])
    }

    @Test
    func checkTuningParameters_inRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let tuning = DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)

        checker.checkTuningParameters(tuning, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkTuningParameters_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let tuning = DKMTuning(primaryInterval: 1.0, notesPerInterval: 1.0, pitchConvExponent: 0.0, pitchConvFactor: 0.0)

        checker.checkTuningParameters(tuning, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "primaryInterval", value: 1.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "notesPerInterval", value: 1.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "pitchConvExponent", value: 0.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "pitchConvFactor", value: 0.0)])
    }

    @Test
    func checkVocodeModeParameters_inRange() {
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

        checker.checkVocodeModeParameters(mode, at: 0)

        #expect(checker.issues.isEmpty)
    }

    @Test
    func checkVocodeModeParameters_outOfRange() {
        var checker = DKMValidator.Checker(score: DKMScore(commands: []))
        let mode = DKMVocodeMode(channel: .left,
                                 name: "Voice",
                                 clipRate: 0.0,
                                 maxHarm: 0,
                                 slope: 9.0,
                                 bassBoost: 16.0,
                                 dynExponent: 5.0,
                                 shiftN: 200,
                                 peakReduction: 13.0)

        checker.checkVocodeModeParameters(mode, at: 0)

        #expect(checker.issues == [.parameterOutOfRange(commandIndex: 0, parameter: "clipRate", value: 0.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "dynExponent", value: 5.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "slope", value: 9.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "bassBoost", value: 16.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "shiftN", value: 200.0),
                                   .parameterOutOfRange(commandIndex: 0, parameter: "peakReduction", value: 13.0)])
    }
}
