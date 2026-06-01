// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing
import XestiTools

struct DKMParseErrorTests {
}

// MARK: -

extension DKMParseErrorTests {
    @Test
    func category() {
        let error = DKMParseError.dataConversionFailed

        #expect(error.category?.description == "IvorJohnnySonic")
    }

    @Test
    func dataConversionFailedMessage() {
        let error = DKMParseError.dataConversionFailed

        #expect(error.message == "Failed to convert data to UTF-8 string")
    }

    @Test
    func invalidParameterCountMessage() {
        let error = DKMParseError.invalidParameterCount(3, 5, 2)

        #expect(error.message == "Invalid parameter count on line 3: expected 5, actual 2")
    }

    @Test
    func invalidParameterValueMessage() {
        let error = DKMParseError.invalidParameterValue(7, "filterType", "99")

        #expect(error.message == "Invalid value for parameter \u{2018}filterType\u{2019} on line 7: \u{2018}99\u{2019}")
    }

    @Test
    func invalidSectionMessage() {
        let error = DKMParseError.invalidSection(1, "Unknown")

        #expect(error.message == "Invalid section name on line 1: \u{2018}/Unknown\u{2019}")
    }

    @Test
    func unexpectedDataLineMessage() {
        let error = DKMParseError.unexpectedDataLine(5)

        #expect(error.message == "Unexpected data line 5: no current section")
    }
}
