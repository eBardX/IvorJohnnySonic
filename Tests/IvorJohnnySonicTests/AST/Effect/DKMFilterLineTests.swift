// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFilterLineTests {
}

// MARK: -

extension DKMFilterLineTests {
    @Test
    func equality() {
        let lhs = DKMFilterLine(startBeat: 0.0,
                                duration: 4.0,
                                filterType: .butterworthLowpass,
                                startPitch: 60.0,
                                endPitch: 60.0,
                                startBandwidth: 2.0,
                                endBandwidth: 2.0)
        let rhs = DKMFilterLine(startBeat: 0.0,
                                duration: 4.0,
                                filterType: .butterworthLowpass,
                                startPitch: 60.0,
                                endPitch: 60.0,
                                startBandwidth: 2.0,
                                endBandwidth: 2.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMFilterLine> = [DKMFilterLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     filterType: .butterworthLowpass,
                                                     startPitch: 60.0,
                                                     endPitch: 60.0,
                                                     startBandwidth: 2.0,
                                                     endBandwidth: 2.0),
                                       DKMFilterLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     filterType: .butterworthLowpass,
                                                     startPitch: 60.0,
                                                     endPitch: 60.0,
                                                     startBandwidth: 2.0,
                                                     endBandwidth: 2.0),
                                       DKMFilterLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     filterType: .butterworthHighpass,
                                                     startPitch: 60.0,
                                                     endPitch: 60.0,
                                                     startBandwidth: 2.0,
                                                     endBandwidth: 2.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMFilterLine(startBeat: 0.0,
                                 duration: 4.0,
                                 filterType: .butterworthLowpass,
                                 startPitch: 60.0,
                                 endPitch: 60.0,
                                 startBandwidth: 2.0,
                                 endBandwidth: 2.0)

        #expect(base != DKMFilterLine(startBeat: 1.0,
                                      duration: 4.0,
                                      filterType: .butterworthLowpass,
                                      startPitch: 60.0,
                                      endPitch: 60.0,
                                      startBandwidth: 2.0,
                                      endBandwidth: 2.0))
        #expect(base != DKMFilterLine(startBeat: 0.0,
                                      duration: 4.0,
                                      filterType: .butterworthHighpass,
                                      startPitch: 60.0,
                                      endPitch: 60.0,
                                      startBandwidth: 2.0,
                                      endBandwidth: 2.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMFilterLine(startBeat: 2.0,
                                 duration: 4.0,
                                 filterType: .firNotch,
                                 startPitch: -220.0,
                                 endPitch: -440.0,
                                 startBandwidth: -12.0,
                                 endBandwidth: -24.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.filterType == .firNotch)
        #expect(line.startPitch == -220.0)
        #expect(line.endPitch == -440.0)
        #expect(line.startBandwidth == -12.0)
        #expect(line.endBandwidth == -24.0)
    }
}
