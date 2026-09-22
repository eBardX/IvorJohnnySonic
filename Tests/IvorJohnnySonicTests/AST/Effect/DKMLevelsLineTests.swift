// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMLevelsLineTests {
}

// MARK: -

extension DKMLevelsLineTests {
    @Test
    func equality() {
        let lhs = DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0)
        let rhs = DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMLevelsLine> = [DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0),
                                       DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0),
                                       DKMLevelsLine(startBeat: 1.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0)

        #expect(base != DKMLevelsLine(startBeat: 1.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0))
        #expect(base != DKMLevelsLine(startBeat: 0.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 3.0))
    }

    @Test
    func init_continuationStartBeat() {
        let line = DKMLevelsLine(startBeat: -1.0, duration: 4.0, startGainLossdB: -6.0, endGainLossdB: 0.0)

        #expect(line.startBeat == -1.0)
    }

    @Test
    func init_setsProperties() {
        let line = DKMLevelsLine(startBeat: 2.0, duration: 4.0, startGainLossdB: -12.0, endGainLossdB: 3.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.startGainLossdB == -12.0)
        #expect(line.endGainLossdB == 3.0)
    }
}
