// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMPulseLineTests {
}

// MARK: -

extension DKMPulseLineTests {
    @Test
    func equality() {
        let lhs = DKMPulseLine(startBeat: 0.0, channel: .both)
        let rhs = DKMPulseLine(startBeat: 0.0, channel: .both)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMPulseLine> = [DKMPulseLine(startBeat: 0.0, channel: .both),
                                      DKMPulseLine(startBeat: 0.0, channel: .both),
                                      DKMPulseLine(startBeat: 0.0, channel: .left)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMPulseLine(startBeat: 0.0, channel: .both)

        #expect(base != DKMPulseLine(startBeat: 1.0, channel: .both))
        #expect(base != DKMPulseLine(startBeat: 0.0, channel: .right))
    }

    @Test
    func init_setsProperties() {
        let line = DKMPulseLine(startBeat: 2.0, channel: .left)

        #expect(line.startBeat == 2.0)
        #expect(line.channel == .left)
    }
}
