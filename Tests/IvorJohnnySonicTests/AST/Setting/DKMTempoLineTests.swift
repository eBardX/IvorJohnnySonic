// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMTempoLineTests {
}

// MARK: -

extension DKMTempoLineTests {
    @Test
    func equality() {
        let lhs = DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0)
        let rhs = DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMTempoLine> = [DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0),
                                      DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0),
                                      DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 90.0, endTempo: 60.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0)

        #expect(base != DKMTempoLine(startBeat: 1.0, duration: 4.0, startTempo: 60.0, endTempo: 60.0))
        #expect(base != DKMTempoLine(startBeat: 0.0, duration: 4.0, startTempo: 60.0, endTempo: 120.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMTempoLine(startBeat: 2.0, duration: 8.0, startTempo: 90.0, endTempo: 120.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 8.0)
        #expect(line.startTempo == 90.0)
        #expect(line.endTempo == 120.0)
    }
}
