// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFilterTypeTests {
}

// MARK: -

extension DKMFilterTypeTests {
    @Test
    func init_rawValue() {
        #expect(DKMFilterType(rawValue: 1) == .allPoleBandpassZeroDBGain)
        #expect(DKMFilterType(rawValue: 2) == .allPoleBandpassPowerPreserving)
        #expect(DKMFilterType(rawValue: 3) == .butterworthLowpass)
        #expect(DKMFilterType(rawValue: 4) == .butterworthHighpass)
        #expect(DKMFilterType(rawValue: 5) == .butterworthBandpass)
        #expect(DKMFilterType(rawValue: 6) == .butterworthNotch)
        #expect(DKMFilterType(rawValue: 13) == .firLowpass)
        #expect(DKMFilterType(rawValue: 14) == .firHighpass)
        #expect(DKMFilterType(rawValue: 16) == .firNotch)
        #expect(DKMFilterType(rawValue: 0) == nil)
        #expect(DKMFilterType(rawValue: 7) == nil)
        #expect(DKMFilterType(rawValue: 15) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMFilterType.allPoleBandpassZeroDBGain.rawValue == 1)
        #expect(DKMFilterType.allPoleBandpassPowerPreserving.rawValue == 2)
        #expect(DKMFilterType.butterworthLowpass.rawValue == 3)
        #expect(DKMFilterType.butterworthHighpass.rawValue == 4)
        #expect(DKMFilterType.butterworthBandpass.rawValue == 5)
        #expect(DKMFilterType.butterworthNotch.rawValue == 6)
        #expect(DKMFilterType.firLowpass.rawValue == 13)
        #expect(DKMFilterType.firHighpass.rawValue == 14)
        #expect(DKMFilterType.firNotch.rawValue == 16)
    }
}
