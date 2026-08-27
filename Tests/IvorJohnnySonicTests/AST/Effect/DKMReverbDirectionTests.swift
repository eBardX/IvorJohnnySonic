// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMReverbDirectionTests {
}

// MARK: -

extension DKMReverbDirectionTests {
    @Test
    func init_rawValue() {
        #expect(DKMReverbDirection(rawValue: -1) == .backward)
        #expect(DKMReverbDirection(rawValue: 1) == .forward)
        #expect(DKMReverbDirection(rawValue: 0) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMReverbDirection.backward.rawValue == -1)
        #expect(DKMReverbDirection.forward.rawValue == 1)
    }
}
