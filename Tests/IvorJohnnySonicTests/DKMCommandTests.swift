// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMCommandTests {
}

// MARK: -

extension DKMCommandTests {
    @Test
    func test_allCasesHaveNonEmptyRawValue() {
        let commands: [DKMCommand] = [.chorus,
                                      .clip,
                                      .comment,
                                      .compress,
                                      .dynamics,
                                      .end,
                                      .exclude,
                                      .filter,
                                      .flange,
                                      .freqBandAnalyze,
                                      .geq,
                                      .haas,
                                      .include,
                                      .levels,
                                      .mix,
                                      .pitches,
                                      .pulse,
                                      .reverb,
                                      .screenOut,
                                      .sendBack,
                                      .showBuffer,
                                      .soundFileName,
                                      .stats,
                                      .tempo,
                                      .tuning,
                                      .vocode]

        for command in commands {
            #expect(!command.rawValue.isEmpty)
        }
    }

    @Test
    func test_commentRawValue() {
        #expect(DKMCommand.comment.rawValue == "comment")
    }

    @Test
    func test_initFromRawValue() {
        #expect(DKMCommand(rawValue: "Chorus") == .chorus)
        #expect(DKMCommand(rawValue: "SFN") == .soundFileName)
        #expect(DKMCommand(rawValue: "FBA") == .freqBandAnalyze)
    }

    @Test
    func test_initFromRawValueInvalid() {
        #expect(DKMCommand(rawValue: "NotACommand") == nil)
    }

    @Test
    func test_rawValues() {
        #expect(DKMCommand.chorus.rawValue == "Chorus")
        #expect(DKMCommand.clip.rawValue == "Clip")
        #expect(DKMCommand.compress.rawValue == "Compress")
        #expect(DKMCommand.dynamics.rawValue == "Dynamics")
        #expect(DKMCommand.end.rawValue == "End")
        #expect(DKMCommand.exclude.rawValue == "Exclude")
        #expect(DKMCommand.filter.rawValue == "Filter")
        #expect(DKMCommand.flange.rawValue == "Flange")
        #expect(DKMCommand.freqBandAnalyze.rawValue == "FBA")
        #expect(DKMCommand.geq.rawValue == "GEQ")
        #expect(DKMCommand.haas.rawValue == "Haas")
        #expect(DKMCommand.include.rawValue == "Include")
        #expect(DKMCommand.levels.rawValue == "Levels")
        #expect(DKMCommand.mix.rawValue == "Mix")
        #expect(DKMCommand.pitches.rawValue == "Pitches")
        #expect(DKMCommand.pulse.rawValue == "Pulse")
        #expect(DKMCommand.reverb.rawValue == "Reverb")
        #expect(DKMCommand.screenOut.rawValue == "ScreenOut")
        #expect(DKMCommand.sendBack.rawValue == "SendBack")
        #expect(DKMCommand.showBuffer.rawValue == "ShowBuffer")
        #expect(DKMCommand.soundFileName.rawValue == "SFN")
        #expect(DKMCommand.stats.rawValue == "Stats")
        #expect(DKMCommand.tempo.rawValue == "Tempo")
        #expect(DKMCommand.tuning.rawValue == "Tuning")
        #expect(DKMCommand.vocode.rawValue == "Vocode")
    }
}
