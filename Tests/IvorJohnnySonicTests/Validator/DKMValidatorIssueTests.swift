// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMValidatorIssueTests {
}

// MARK: -

extension DKMValidatorIssueTests {
    @Test
    func beatExceedsTableSizeMessage() {
        let issue = DKMValidator.Issue.beatExceedsTableSize(commandIndex: 3, beat: 9_000.0)

        #expect(issue.message == "Command 3 has a beat (9000.0) that exceeds the maximum table size of 8192")
    }

    @Test
    func clipNoteWithoutModeMessage() {
        let issue = DKMValidator.Issue.clipNoteWithoutMode(commandIndex: 2)

        #expect(issue.message == "Command 2 is a clip note with no preceding clip mode command")
    }

    @Test
    func commandIndex_allCases() {
        #expect(DKMValidator.Issue.beatExceedsTableSize(commandIndex: 0, beat: 9_000.0).commandIndex == 0)
        #expect(DKMValidator.Issue.clipNoteWithoutMode(commandIndex: 1).commandIndex == 1)
        #expect(DKMValidator.Issue.incompleteGraphicEQSegment(commandIndex: 2).commandIndex == 2)
        #expect(DKMValidator.Issue.invalidBandGainCount(commandIndex: 3, count: 31).commandIndex == 3)
        #expect(DKMValidator.Issue.nonFiniteParameter(commandIndex: 4, parameter: "startBeat").commandIndex == 4)
        #expect(DKMValidator.Issue.nonPositiveDuration(commandIndex: 5, duration: 0.0).commandIndex == 5)
        #expect(DKMValidator.Issue.nonPositiveTempo(commandIndex: 6, tempo: 0.0).commandIndex == 6)
        #expect(DKMValidator.Issue.parameterOutOfRange(commandIndex: 7, parameter: "maxRatio", value: 1.0).commandIndex == 7)
        #expect(DKMValidator.Issue.unwritableName(commandIndex: 8, name: "").commandIndex == 8)
        #expect(DKMValidator.Issue.vocodeNoteWithoutMode(commandIndex: 9).commandIndex == 9)
    }

    @Test
    func hashable() {
        let set: Set<DKMValidator.Issue> = [.clipNoteWithoutMode(commandIndex: 0),
                                            .clipNoteWithoutMode(commandIndex: 0),
                                            .vocodeNoteWithoutMode(commandIndex: 0)]

        #expect(set.count == 2)
    }

    @Test
    func incompleteGraphicEQSegmentMessage() {
        let issue = DKMValidator.Issue.incompleteGraphicEQSegment(commandIndex: 4)

        #expect(issue.message == "Command 4 is a GEQ line with no adjacent GEQ line to complete its segment")
    }

    @Test
    func inequality_differentCase() {
        #expect(DKMValidator.Issue.clipNoteWithoutMode(commandIndex: 0) != .vocodeNoteWithoutMode(commandIndex: 0))
    }

    @Test
    func invalidBandGainCountMessage() {
        let issue = DKMValidator.Issue.invalidBandGainCount(commandIndex: 1, count: 31)

        #expect(issue.message == "Command 1 specifies 31 band gain(s), which exceeds the maximum of 30")
    }

    @Test
    func nonFiniteParameterMessage() {
        let issue = DKMValidator.Issue.nonFiniteParameter(commandIndex: 6, parameter: "startBeat")

        #expect(issue.message == "Command 6 has a non-finite value for startBeat")
    }

    @Test
    func nonPositiveDurationMessage() {
        let issue = DKMValidator.Issue.nonPositiveDuration(commandIndex: 7, duration: 0.0)

        #expect(issue.message == "Command 7 has a non-positive duration (0.0)")
    }

    @Test
    func nonPositiveTempoMessage() {
        let issue = DKMValidator.Issue.nonPositiveTempo(commandIndex: 8, tempo: -1.0)

        #expect(issue.message == "Command 8 has a non-positive tempo (-1.0)")
    }

    @Test
    func parameterOutOfRangeMessage() {
        let issue = DKMValidator.Issue.parameterOutOfRange(commandIndex: 9, parameter: "maxRatio", value: 1.0)

        #expect(issue.message == "Command 9 has maxRatio (1.0) out of range")
    }

    @Test
    func unwritableNameMessage() {
        let issue = DKMValidator.Issue.unwritableName(commandIndex: 10, name: "bad name")

        #expect(issue.message == "Command 10 has an unwritable name (\"bad name\")")
    }

    @Test
    func vocodeNoteWithoutModeMessage() {
        let issue = DKMValidator.Issue.vocodeNoteWithoutMode(commandIndex: 11)

        #expect(issue.message == "Command 11 is a vocode note with no preceding vocode mode command")
    }
}
