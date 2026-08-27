// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMValidatorTests {
}

// MARK: -

extension DKMValidatorTests {
    @Test
    func validate_alreadyValidated_returnsUnchanged() throws {
        let score = DKMScore(commands: [.end],
                             isNormalized: true,
                             isValidated: true)
        let (validated, issues) = try DKMValidator().validate(score)

        #expect(validated == score)
        #expect(validated.isValidated == true)
        #expect(issues.isEmpty)
    }

    @Test
    func validate_beatExceedsTableSize() throws {
        let line = DKMPulseLine(startBeat: 9_000.0, channel: .both)
        let score = DKMScore(commands: [.pulseLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues == [.beatExceedsTableSize(commandIndex: 0, beat: 9_000.0)])
    }

    @Test
    func validate_cleanScore_noIssues() throws {
        let score = DKMScore(commands: [.end],
                             isNormalized: true,
                             isValidated: false)
        let (validated, issues) = try DKMValidator().validate(score)

        #expect(issues.isEmpty)
        #expect(validated.isValidated == true)
    }

    @Test
    func validate_clipNoteWithoutMode() throws {
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 1.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipNote(note)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.clipNoteWithoutMode(commandIndex: 0)))
    }

    @Test
    func validate_incompleteGraphicEQSegment() throws {
        let line = DKMGEQLine(beat: 0.0, bandGains: [0.0])
        let score = DKMScore(commands: [.geqLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.incompleteGraphicEQSegment(commandIndex: 0)))
    }

    @Test
    func validate_invalidBandGainCount() throws {
        let gains = Array(repeating: 0.0, count: 31)
        let line1 = DKMGEQLine(beat: 0.0, bandGains: gains)
        let line2 = DKMGEQLine(beat: 4.0, bandGains: gains)
        let score = DKMScore(commands: [.geqLine(line1), .geqLine(line2)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.invalidBandGainCount(commandIndex: 0, count: 31)))
    }

    @Test
    func validate_isValidatedShortCircuitsBeforeNormalizedCheck() throws {
        // isValidated is checked first, so an already-validated score never
        // trips the isNormalized guard, even when it is (falsely) false.
        let score = DKMScore(commands: [.end],
                             isNormalized: false,
                             isValidated: true)
        let (validated, issues) = try DKMValidator().validate(score)

        #expect(validated == score)
        #expect(issues.isEmpty)
    }

    @Test
    func validate_multipleIssues_accumulate() throws {
        let note = DKMClipNote(startBeat: 0.0,
                               duration: 0.0,
                               volume: 1.0,
                               location: 0.0,
                               clipStart: 0.0,
                               clipRate: 1.0,
                               instrument: "Clip")
        let score = DKMScore(commands: [.clipNote(note)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.clipNoteWithoutMode(commandIndex: 0)))
        #expect(issues.contains(.nonPositiveDuration(commandIndex: 0, duration: 0.0)))
        #expect(issues.count == 2)
    }

    @Test
    func validate_nonFiniteParameter() throws {
        let line = DKMShowBufferLine(startBeat: .nan, duration: 1.0)
        let score = DKMScore(commands: [.showBufferLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.nonFiniteParameter(commandIndex: 0, parameter: "startBeat")))
    }

    @Test
    func validate_nonPositiveDuration() throws {
        let line = DKMStatsLine(startBeat: 0.0, duration: 0.0)
        let score = DKMScore(commands: [.statsLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.nonPositiveDuration(commandIndex: 0, duration: 0.0)))
    }

    @Test
    func validate_nonPositiveTempo() throws {
        let line = DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 0.0, finalTempo: 60.0)
        let score = DKMScore(commands: [.tempoLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.nonPositiveTempo(commandIndex: 0, tempo: 0.0)))
    }

    @Test
    func validate_notNormalized_throws() {
        let score = DKMScore(commands: [.end])

        #expect(throws: DKMValidator.Error.notNormalized) {
            try DKMValidator().validate(score)
        }
    }

    @Test
    func validate_parameterOutOfRange() throws {
        let line = DKMCompressLine(startBeat: 0.0, duration: 1.0, maxRatio: 1.0)
        let score = DKMScore(commands: [.compressLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.parameterOutOfRange(commandIndex: 0, parameter: "maxRatio", value: 1.0)))
    }

    @Test
    func validate_scoreWithIssue_isValidatedStaysFalse() throws {
        let line = DKMStatsLine(startBeat: 0.0, duration: 0.0)
        let score = DKMScore(commands: [.statsLine(line)],
                             isNormalized: true,
                             isValidated: false)
        let (validated, issues) = try DKMValidator().validate(score)

        #expect(!issues.isEmpty)
        #expect(validated.isValidated == false)
        #expect(validated == score)
    }

    @Test
    func validate_unwritableName() throws {
        let score = DKMScore(commands: [.soundFileName("")],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.unwritableName(commandIndex: 0, name: "")))
    }

    @Test
    func validate_vocodeNoteWithoutMode() throws {
        let note = DKMVocodeNote(startBeat: 0.0,
                                 duration: 1.0,
                                 volume: 1.0,
                                 location: 0.0,
                                 pitch: 60.0,
                                 clipStart: 0.0,
                                 instrument: "Voc")
        let score = DKMScore(commands: [.vocodeNote(note)],
                             isNormalized: true,
                             isValidated: false)
        let (_, issues) = try DKMValidator().validate(score)

        #expect(issues.contains(.vocodeNoteWithoutMode(commandIndex: 0)))
    }
}
