// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMParserReaderTests {
}

// MARK: -

extension DKMParserReaderTests {
    @Test
    func readScore_comment() throws {
        var reader = DKMParser.Reader(lines: ["! Hello"])

        let score = try reader.readScore()

        #expect(score.commands == [.comment(" Hello")])
    }

    @Test
    func readScore_emptyLines() throws {
        var reader = DKMParser.Reader(lines: [])

        let score = try reader.readScore()

        #expect(score.commands.isEmpty)
    }

    @Test
    func readScore_ignoresWhitespaceOnlyLines() throws {
        var reader = DKMParser.Reader(lines: ["  ", "/End", "\t"])

        let score = try reader.readScore()

        #expect(score.commands == [.end])
    }

    @Test
    func readScore_invalidParameterCountThrows() {
        var reader = DKMParser.Reader(lines: ["/Tempo", "0.0 1.0"])

        #expect(throws: DKMParseError.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_invalidParameterValueThrows() {
        var reader = DKMParser.Reader(lines: ["/ScreenOut", "foo"])

        #expect(throws: DKMParseError.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_invalidSectionThrows() {
        var reader = DKMParser.Reader(lines: ["/Unknown"])

        #expect(throws: DKMParseError.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_multipleCommands() throws {
        var reader = DKMParser.Reader(lines: ["/Tempo", "0.0 1.0 60.0 60.0", "/Pulse", "10.0 B"])

        let score = try reader.readScore()

        #expect(score.commands == [.tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0),
                                   .pulseLine(startBeat: 10.0, channel: .both)])
    }

    @Test
    func readScore_singleCommand() throws {
        var reader = DKMParser.Reader(lines: ["/End"])

        let score = try reader.readScore()

        #expect(score.commands == [.end])
    }

    @Test
    func readScore_unexpectedDataLineThrows() {
        var reader = DKMParser.Reader(lines: ["0.0 1.0 57.0 57.0"])

        #expect(throws: DKMParseError.self) {
            try reader.readScore()
        }
    }
}
