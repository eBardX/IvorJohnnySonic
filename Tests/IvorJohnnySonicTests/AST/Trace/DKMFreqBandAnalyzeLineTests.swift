// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFreqBandAnalyzeLineTests {
}

// MARK: -

extension DKMFreqBandAnalyzeLineTests {
    @Test
    func equality() {
        let lhs = DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound)
        let rhs = DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMFreqBandAnalyzeLine> = [DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound),
                                                DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound),
                                                DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .left, buffer: .sound)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .sound)

        #expect(base != DKMFreqBandAnalyzeLine(startBeat: 1.0, duration: 4.0, channel: .combined, buffer: .sound))
        #expect(base != DKMFreqBandAnalyzeLine(startBeat: 0.0, duration: 4.0, channel: .combined, buffer: .mix))
    }

    @Test
    func init_setsProperties() {
        let line = DKMFreqBandAnalyzeLine(startBeat: 2.0, duration: 4.0, channel: .right, buffer: .mix)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.channel == .right)
        #expect(line.buffer == .mix)
    }
}
