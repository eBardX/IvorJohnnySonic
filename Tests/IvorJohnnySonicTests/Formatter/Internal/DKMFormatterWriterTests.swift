// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import IvorJohnnySonic
import Testing

struct DKMFormatterWriterTests {
}

// MARK: -

extension DKMFormatterWriterTests {
    @Test
    func writeScore_comment() throws {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [.comment(" Hello")]))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result == "! Hello\n")
    }

    @Test
    func writeScore_emptyScore() throws {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: []))

        let data = try writer.writeScore()

        #expect(data.isEmpty)
    }

    @Test
    func writeScore_forcesSectionForClipMode() throws {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [.clipMode(DKMClipMode(channel: .right, name: "FirstClip")),
                                                                    .clipMode(DKMClipMode(channel: .left, name: "SecondClip"))]))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result == "/Clip\n1 FirstClip\n/Clip\n0 SecondClip\n")
    }

    @Test
    func writeScore_forcesSectionForVocodeMode() throws {
        let mode = DKMCommand.vocodeMode(DKMVocodeMode(channel: .right,
                                                       name: "ExtSound",
                                                       clipRate: 1.0,
                                                       maxHarm: 0,
                                                       slope: 0.0,
                                                       bassBoost: 0.0,
                                                       dynExponent: 1.0,
                                                       shiftN: 0,
                                                       peakReduction: 0.0))
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [mode, mode]))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result == "/Vocode\n1 ExtSound 1.0 0 0.0 0.0 1.0 0 0.0\n"
                         + "/Vocode\n1 ExtSound 1.0 0 0.0 0.0 1.0 0 0.0\n")
    }

    @Test
    func writeScore_invalidStringThrows() {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [.soundFileName("bad\nvalue")]))

        #expect(throws: DKMFormatter.Error.self) {
            try writer.writeScore()
        }
    }

    @Test
    func writeScore_multipleCommands() throws {
        let commands: [DKMCommand] = [.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0)),
                                      .pulseLine(DKMPulseLine(startBeat: 10.0, channel: .both))]
        var writer = DKMFormatter.Writer(score: DKMScore(commands: commands))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result == "/Tempo\n0.0 1.0 60.0 60.0\n/Pulse\n10.0 B\n")
    }

    @Test
    func writeScore_returnsValidUTF8Data() throws {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [.end]))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result != nil)
    }

    @Test
    func writeScore_singleCommand() throws {
        var writer = DKMFormatter.Writer(score: DKMScore(commands: [.end]))

        let data = try writer.writeScore()
        let result = String(data: data, encoding: .utf8)

        #expect(result == "/End\n")
    }
}
