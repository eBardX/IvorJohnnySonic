// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMParserDiagnosticTests {
}

// MARK: -

extension DKMParserDiagnosticTests {
    @Test
    func bandGainCountMismatchMessage() {
        let diagnostic = DKMParser.Diagnostic.bandGainCountMismatch(lineNumber: 12, count: 29)

        #expect(diagnostic.message == "\u{2018}/GEQ\u{2019} line 12 declared 29 band gain(s); expected 30")
    }

    @Test
    func hashable() {
        let set: Set<DKMParser.Diagnostic> = [.bandGainCountMismatch(lineNumber: 1, count: 29),
                                              .bandGainCountMismatch(lineNumber: 1, count: 29),
                                              .truncatedIntegerParameter(lineNumber: 1, parameter: "numberOfVoices", value: 4.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality_differentCase() {
        #expect(DKMParser.Diagnostic.bandGainCountMismatch(lineNumber: 1, count: 29) !=
                    .truncatedIntegerParameter(lineNumber: 1, parameter: "numberOfVoices", value: 4.0))
    }

    @Test
    func truncatedIntegerParameterMessage() {
        let diagnostic = DKMParser.Diagnostic.truncatedIntegerParameter(lineNumber: 3,
                                                                        parameter: "numberOfVoices",
                                                                        value: 4.0)

        #expect(diagnostic.message == "Parameter \u{2018}numberOfVoices\u{2019} on line 3 truncated from 4.0 to 4")
    }
}
