// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMChorusLineTests {
}

// MARK: -

extension DKMChorusLineTests {
    @Test
    func equality() {
        let lhs = DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)
        let rhs = DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMChorusLine> = [DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false),
                                       DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false),
                                       DKMChorusLine(startBeat: 1.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)

        #expect(base != DKMChorusLine(startBeat: 1.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false))
        #expect(base != DKMChorusLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: true))
    }

    @Test
    func init_setsProperties() {
        let line = DKMChorusLine(startBeat: 2.0, duration: 4.0, numberOfVoices: 6, depth: 0.75, flipChannels: true)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.numberOfVoices == 6)
        #expect(line.depth == 0.75)
        #expect(line.flipChannels)
    }
}
