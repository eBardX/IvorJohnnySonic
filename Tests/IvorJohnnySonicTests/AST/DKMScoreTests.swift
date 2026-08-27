// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMScoreTests {
}

// MARK: -

extension DKMScoreTests {
    @Test
    func equality() {
        let lhs = DKMScore(commands: [.end])
        let rhs = DKMScore(commands: [.end])

        #expect(lhs == rhs)

        let emptyLhs = DKMScore(commands: [])
        let emptyRhs = DKMScore(commands: [])

        #expect(emptyLhs == emptyRhs)
    }

    @Test
    func equality_ignoresFlags() {
        let lhs = DKMScore(commands: [.end])
        let rhs = DKMScore(commands: [.end],
                           isNormalized: true,
                           isValidated: true)

        #expect(lhs.isNormalized != rhs.isNormalized)
        #expect(lhs.isValidated != rhs.isValidated)
        #expect(lhs == rhs)
        #expect(lhs.hashValue == rhs.hashValue)
    }

    @Test
    func inequality() {
        #expect(DKMScore(commands: [.end]) != DKMScore(commands: []))
        #expect(DKMScore(commands: [.end]) != DKMScore(commands: [.exclude]))
    }

    @Test
    func initSetsFlagsFalse() {
        let score = DKMScore(commands: [.end])

        #expect(score.isNormalized == false)
        #expect(score.isValidated == false)
    }

    @Test
    func initWithEmptyCommands() {
        let score = DKMScore(commands: [])

        #expect(score.commands.isEmpty)
    }

    @Test
    func initWithMultipleCommands() {
        let commands: [DKMCommand] = [.soundFileName("test.aiff"),
                                      .tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0)),
                                      .end]
        let score = DKMScore(commands: commands)

        #expect(score.commands.count == 3)

        if case let .soundFileName(name) = score.commands[0] {
            #expect(name == "test.aiff")
        } else {
            Issue.record("Expected .soundFileName command")
        }

        if case let .tempoLine(line) = score.commands[1] {
            #expect(line.startBeat == 0.0)
            #expect(line.duration == 1.0)
            #expect(line.initialTempo == 60.0)
            #expect(line.finalTempo == 60.0)
        } else {
            Issue.record("Expected .tempoLine command")
        }

        if case .end = score.commands[2] {
            // pass
        } else {
            Issue.record("Expected .end command")
        }
    }

    @Test
    func initWithSingleCommand() {
        let score = DKMScore(commands: [.end])

        #expect(score.commands.count == 1)

        if case .end = score.commands[0] {
            // pass
        } else {
            Issue.record("Expected .end command")
        }
    }
}
