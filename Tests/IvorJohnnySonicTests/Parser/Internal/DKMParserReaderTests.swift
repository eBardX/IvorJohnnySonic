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

        let (score, _) = try reader.readScore()

        #expect(score.commands == [.comment(" Hello")])
    }

    @Test
    func readScore_emptyLines() throws {
        var reader = DKMParser.Reader(lines: [])

        let (score, _) = try reader.readScore()

        #expect(score.commands.isEmpty)
    }

    @Test
    func readScore_geqLineWithBandGainCountMismatch_producesDiagnostic() throws {
        var reader = DKMParser.Reader(lines: ["/GEQ", "0.0 1.0 2.0"])

        let (_, diagnostics) = try reader.readScore()

        #expect(diagnostics == [.bandGainCountMismatch(lineNumber: 2, count: 2)])
    }

    @Test
    func readScore_ignoresWhitespaceOnlyLines() throws {
        var reader = DKMParser.Reader(lines: ["  ", "/End", "\t"])

        let (score, _) = try reader.readScore()

        #expect(score.commands == [.end])
    }

    @Test
    func readScore_invalidParameterCountThrows() {
        var reader = DKMParser.Reader(lines: ["/Tempo", "0.0 1.0"])

        #expect(throws: DKMParser.Error.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_invalidParameterValueThrows() {
        var reader = DKMParser.Reader(lines: ["/ScreenOut", "foo"])

        #expect(throws: DKMParser.Error.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_invalidSectionThrows() {
        var reader = DKMParser.Reader(lines: ["/Unknown"])

        #expect(throws: DKMParser.Error.self) {
            try reader.readScore()
        }
    }

    @Test
    func readScore_multipleCommands() throws {
        var reader = DKMParser.Reader(lines: ["/Tempo", "0.0 1.0 60.0 60.0", "/Pulse", "10.0 B"])

        let (score, _) = try reader.readScore()

        #expect(score.commands == [.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0)),
                                   .pulseLine(DKMPulseLine(startBeat: 10.0, channel: .both))])
    }

    @Test
    func readScore_noDiagnosticsByDefault() throws {
        var reader = DKMParser.Reader(lines: ["/End"])

        let (_, diagnostics) = try reader.readScore()

        #expect(diagnostics.isEmpty)
    }

    @Test
    func readScore_singleCommand() throws {
        var reader = DKMParser.Reader(lines: ["/End"])

        let (score, _) = try reader.readScore()

        #expect(score.commands == [.end])
    }

    @Test
    func readScore_unexpectedDataLineThrows() {
        var reader = DKMParser.Reader(lines: ["0.0 1.0 57.0 57.0"])

        #expect(throws: DKMParser.Error.self) {
            try reader.readScore()
        }
    }
}
