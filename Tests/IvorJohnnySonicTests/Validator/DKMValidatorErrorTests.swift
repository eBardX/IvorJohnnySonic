// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing
import XestiTools

struct DKMValidatorErrorTests {
}

// MARK: -

extension DKMValidatorErrorTests {
    @Test
    func category() {
        let error = DKMValidator.Error.notNormalized

        #expect(error.category?.description == "IvorJohnnySonic")
    }

    @Test
    func notNormalizedMessage() {
        let error = DKMValidator.Error.notNormalized

        #expect(error.message == "Score must be normalized before validation; call DKMNormalizer.normalize(_:) first")
    }
}
