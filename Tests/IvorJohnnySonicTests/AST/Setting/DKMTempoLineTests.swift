// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMTempoLineTests {
}

// MARK: -

extension DKMTempoLineTests {
    @Test
    func equality() {
        let lhs = DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0)
        let rhs = DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMTempoLine> = [DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0),
                                      DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0),
                                      DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 90.0, finalTempo: 60.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0)

        #expect(base != DKMTempoLine(startBeat: 1.0, duration: 4.0, initialTempo: 60.0, finalTempo: 60.0))
        #expect(base != DKMTempoLine(startBeat: 0.0, duration: 4.0, initialTempo: 60.0, finalTempo: 120.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMTempoLine(startBeat: 2.0, duration: 8.0, initialTempo: 90.0, finalTempo: 120.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 8.0)
        #expect(line.initialTempo == 90.0)
        #expect(line.finalTempo == 120.0)
    }
}
