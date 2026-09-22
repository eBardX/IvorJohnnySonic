// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMShowBufferLineTests {
}

// MARK: -

extension DKMShowBufferLineTests {
    @Test
    func equality() {
        let lhs = DKMShowBufferLine(startBeat: 0.0, duration: 4.0)
        let rhs = DKMShowBufferLine(startBeat: 0.0, duration: 4.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMShowBufferLine> = [DKMShowBufferLine(startBeat: 0.0, duration: 4.0),
                                           DKMShowBufferLine(startBeat: 0.0, duration: 4.0),
                                           DKMShowBufferLine(startBeat: 1.0, duration: 4.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMShowBufferLine(startBeat: 0.0, duration: 4.0)

        #expect(base != DKMShowBufferLine(startBeat: 1.0, duration: 4.0))
        #expect(base != DKMShowBufferLine(startBeat: 0.0, duration: 8.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMShowBufferLine(startBeat: 2.0, duration: 4.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
    }
}
