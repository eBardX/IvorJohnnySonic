// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMCompressLineTests {
}

// MARK: -

extension DKMCompressLineTests {
    @Test
    func equality() {
        let lhs = DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0)
        let rhs = DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMCompressLine> = [DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0),
                                         DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0),
                                         DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 9.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 6.0)

        #expect(base != DKMCompressLine(startBeat: 1.0, duration: 4.0, maxRatio: 6.0))
        #expect(base != DKMCompressLine(startBeat: 0.0, duration: 4.0, maxRatio: 9.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMCompressLine(startBeat: 2.0, duration: 4.0, maxRatio: 12.0)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.maxRatio == 12.0)
    }
}
