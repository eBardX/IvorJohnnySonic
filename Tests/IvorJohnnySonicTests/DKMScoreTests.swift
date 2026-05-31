// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMScoreTests {
}

// MARK: -

extension DKMScoreTests {
    @Test
    func initWithEmptyCommands() {
        let score = DKMScore(commands: [])

        #expect(score.commands.isEmpty)
    }

    @Test
    func initWithMultipleCommands() {
        let commands: [DKMCommand] = [.soundFileName("test.aiff"),
                                      .tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0),
                                      .end]
        let score = DKMScore(commands: commands)

        #expect(score.commands.count == 3)

        if case let .soundFileName(name) = score.commands[0] {
            #expect(name == "test.aiff")
        } else {
            Issue.record("Expected .soundFileName command")
        }

        if case let .tempoLine(startBeat, duration, initialTempo, finalTempo) = score.commands[1] {
            #expect(startBeat == 0.0)
            #expect(duration == 1.0)
            #expect(initialTempo == 60.0)
            #expect(finalTempo == 60.0)
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
