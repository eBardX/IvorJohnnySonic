// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFBABufferTests {
}

// MARK: -

extension DKMFBABufferTests {
    @Test
    func init_rawValue() {
        #expect(DKMFBABuffer(rawValue: "M") == .mix)
        #expect(DKMFBABuffer(rawValue: "S") == .sound)
        #expect(DKMFBABuffer(rawValue: "X") == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMFBABuffer.mix.rawValue == "M")
        #expect(DKMFBABuffer.sound.rawValue == "S")
    }
}
