// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMStatsLineTests {
}

// MARK: -

extension DKMStatsLineTests {
    @Test
    func equality() {
        let lhs = DKMStatsLine(startBeat: 0.0, duration: 4.0)
        let rhs = DKMStatsLine(startBeat: 0.0, duration: 4.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMStatsLine> = [DKMStatsLine(startBeat: 0.0, duration: 4.0),
                                      DKMStatsLine(startBeat: 0.0, duration: 4.0),
                                      DKMStatsLine(startBeat: 1.0, duration: 4.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMStatsLine(startBeat: 0.0, duration: 4.0)

        #expect(base != DKMStatsLine(startBeat: 1.0, duration: 4.0))
        #expect(base != DKMStatsLine(startBeat: 0.0, duration: 8.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMStatsLine(startBeat: 2.0, duration: 4.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
    }
}
