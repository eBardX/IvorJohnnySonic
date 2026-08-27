// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing
import XestiTools

struct DKMFormatterErrorTests {
}

// MARK: -

extension DKMFormatterErrorTests {
    @Test
    func category() {
        let error = DKMFormatter.Error.stringConversionFailed

        #expect(error.category?.description == "IvorJohnnySonic")
    }

    @Test
    func invalidStringArgumentMessage() {
        let error = DKMFormatter.Error.invalidStringArgument("bad\nvalue")

        #expect(error.message == "String argument contains invalid characters: bad\nvalue")
    }

    @Test
    func message() {
        let error = DKMFormatter.Error.stringConversionFailed

        #expect(error.message == "Failed to convert string to UTF-8 data")
    }

    @Test
    func notValidatedMessage() {
        let error = DKMFormatter.Error.notValidated

        #expect(error.message == "Score must be validated before formatting; call DKMValidator.validate(_:) first")
    }
}
