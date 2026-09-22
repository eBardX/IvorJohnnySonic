// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMGEQLineTests {
}

// MARK: -

extension DKMGEQLineTests {
    @Test
    func equality() {
        let lhs = DKMGEQLine(beat: 0.0, bandGains: [1.0, 2.0, 3.0])
        let rhs = DKMGEQLine(beat: 0.0, bandGains: [1.0, 2.0, 3.0])

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMGEQLine> = [DKMGEQLine(beat: 0.0, bandGains: [1.0, 2.0]),
                                    DKMGEQLine(beat: 0.0, bandGains: [1.0, 2.0]),
                                    DKMGEQLine(beat: 1.0, bandGains: [1.0, 2.0])]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMGEQLine(beat: 0.0, bandGains: [1.0, 2.0])

        #expect(base != DKMGEQLine(beat: 1.0, bandGains: [1.0, 2.0]))
        #expect(base != DKMGEQLine(beat: 0.0, bandGains: [1.0, 3.0]))
    }

    @Test
    func init_emptyBandGains() {
        let line = DKMGEQLine(beat: 4.0, bandGains: [])

        #expect(line.beat == 4.0)
        #expect(line.bandGains.isEmpty)
    }

    @Test
    func init_setsProperties() {
        let bandGains = (0..<30).map { Double($0) }
        let line = DKMGEQLine(beat: 4.0, bandGains: bandGains)

        #expect(line.beat == 4.0)
        #expect(line.bandGains == bandGains)
    }
}
