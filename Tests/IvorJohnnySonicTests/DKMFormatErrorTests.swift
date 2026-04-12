// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing
import XestiTools

struct DKMFormatErrorTests {
}

// MARK: -

extension DKMFormatErrorTests {
    @Test
    func test_category() {
        let error = DKMFormatError.stringConversionFailed

        #expect(error.category?.description == "IvorJohnnySonic")
    }

    @Test
    func test_invalidStringArgumentMessage() {
        let error = DKMFormatError.invalidStringArgument("bad\nvalue")

        #expect(error.message == "String argument contains invalid characters: bad\nvalue")
    }

    @Test
    func test_message() {
        let error = DKMFormatError.stringConversionFailed

        #expect(error.message == "Failed to convert string to UTF-8 data")
    }
}
