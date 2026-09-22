// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMNormalizerEditorTests {
}

// MARK: -

extension DKMNormalizerEditorTests {
    @Test
    func editScore_geqLineWithNegativeBeat_clampsBeatToZero() {
        let line = DKMGEQLine(beat: -1.0, bandGains: [0.0, 0.0])
        let score = DKMScore(commands: [.geqLine(line)])
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, changes) = editor.editScore()

        #expect(changes == [.clampedNegativeStartBeat(commandIndex: 0, startBeat: -1.0)])
        #expect(normalized.commands == [.geqLine(DKMGEQLine(beat: 0.0, bandGains: [0.0, 0.0]))])
    }

    @Test
    func editScore_negativeDuration_clampsToZero() {
        let line = DKMChorusLine(startBeat: 0.0,
                                 duration: -4.0,
                                 numberOfVoices: 4,
                                 depth: 0.5,
                                 flipChannels: false)
        let score = DKMScore(commands: [.chorusLine(line)])
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, changes) = editor.editScore()

        #expect(changes == [.clampedNegativeDuration(commandIndex: 0, duration: -4.0)])
        #expect(normalized.commands == [.chorusLine(DKMChorusLine(startBeat: 0.0,
                                                                  duration: 0.0,
                                                                  numberOfVoices: 4,
                                                                  depth: 0.5,
                                                                  flipChannels: false))])
    }

    @Test
    func editScore_noEditsNeeded_reportsNoChanges() {
        let score = DKMScore(commands: [.comment("test"), .dynamics, .end])
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, changes) = editor.editScore()

        #expect(changes.isEmpty)
        #expect(normalized.commands == score.commands)
    }

    @Test
    func editScore_pulseLineWithNegativeStartBeat_clampsToZero() {
        let line = DKMPulseLine(startBeat: -3.0, channel: .both)
        let score = DKMScore(commands: [.pulseLine(line)])
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, changes) = editor.editScore()

        #expect(changes == [.clampedNegativeStartBeat(commandIndex: 0, startBeat: -3.0)])
        #expect(normalized.commands == [.pulseLine(DKMPulseLine(startBeat: 0.0, channel: .both))])
    }

    @Test
    func editScore_sendBackLineWithNegativeStartBeat_clampsToZero() {
        let line = DKMSendBackLine(startBeat: -2.0, duration: 4.0, gainLossdB: -3.0)
        let score = DKMScore(commands: [.sendBackLine(line)])
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, changes) = editor.editScore()

        #expect(changes == [.clampedNegativeStartBeat(commandIndex: 0, startBeat: -2.0)])
        #expect(normalized.commands == [.sendBackLine(DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0))])
    }

    @Test
    func editScore_setsIsNormalizedAndClearsIsValidated() {
        let score = DKMScore(commands: [.end],
                             isNormalized: false,
                             isValidated: true)
        var editor = DKMNormalizer.Editor(score: score)
        let (normalized, _) = editor.editScore()

        #expect(normalized.isNormalized == true)
        #expect(normalized.isValidated == false)
    }
}
