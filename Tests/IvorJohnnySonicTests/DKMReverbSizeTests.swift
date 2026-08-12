// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMReverbSizeTests {
}

// MARK: -

extension DKMReverbSizeTests {
    @Test
    func init_rawValue() {
        #expect(DKMReverbSize(rawValue: 1) == .small)
        #expect(DKMReverbSize(rawValue: 2) == .medium)
        #expect(DKMReverbSize(rawValue: 3) == .large)
        #expect(DKMReverbSize(rawValue: 0) == nil)
        #expect(DKMReverbSize(rawValue: 4) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMReverbSize.small.rawValue == 1)
        #expect(DKMReverbSize.medium.rawValue == 2)
        #expect(DKMReverbSize.large.rawValue == 3)
    }
}
