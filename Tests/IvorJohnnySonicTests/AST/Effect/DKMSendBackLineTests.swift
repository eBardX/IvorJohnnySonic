// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMSendBackLineTests {
}

// MARK: -

extension DKMSendBackLineTests {
    @Test
    func equality() {
        let lhs = DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0)
        let rhs = DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMSendBackLine> = [DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0),
                                         DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0),
                                         DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: 3.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: -3.0)

        #expect(base != DKMSendBackLine(startBeat: 1.0, duration: 4.0, gainLossdB: -3.0))
        #expect(base != DKMSendBackLine(startBeat: 0.0, duration: 4.0, gainLossdB: 3.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMSendBackLine(startBeat: 2.0, duration: 4.0, gainLossdB: 6.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.gainLossdB == 6.0)
    }
}
