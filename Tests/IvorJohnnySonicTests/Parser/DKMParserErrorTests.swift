// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing
import XestiTools

struct DKMParserErrorTests {
}

// MARK: -

extension DKMParserErrorTests {
    @Test
    func category() {
        let error = DKMParser.Error.dataConversionFailed

        #expect(error.category?.description == "IvorJohnnySonic")
    }

    @Test
    func dataConversionFailedMessage() {
        let error = DKMParser.Error.dataConversionFailed

        #expect(error.message == "Failed to convert data to UTF-8 string")
    }

    @Test
    func invalidParameterCountMessage() {
        let error = DKMParser.Error.invalidParameterCount(3, 5, 2)

        #expect(error.message == "Invalid parameter count on line 3: expected 5, actual 2")
    }

    @Test
    func invalidParameterValueMessage() {
        let error = DKMParser.Error.invalidParameterValue(7, "filterType", "99")

        #expect(error.message == "Invalid value for parameter \u{2018}filterType\u{2019} on line 7: \u{2018}99\u{2019}")
    }

    @Test
    func invalidSectionMessage() {
        let error = DKMParser.Error.invalidSection(1, "Unknown")

        #expect(error.message == "Invalid section name on line 1: \u{2018}/Unknown\u{2019}")
    }

    @Test
    func unexpectedDataLineMessage() {
        let error = DKMParser.Error.unexpectedDataLine(5)

        #expect(error.message == "Unexpected data line 5: no current section")
    }
}
