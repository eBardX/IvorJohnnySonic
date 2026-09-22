// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFlangeLineTests {
}

// MARK: -

extension DKMFlangeLineTests {
    @Test
    func equality() {
        let lhs = DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)
        let rhs = DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMFlangeLine> = [DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false),
                                       DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false),
                                       DKMFlangeLine(startBeat: 1.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false)

        #expect(base != DKMFlangeLine(startBeat: 1.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: false))
        #expect(base != DKMFlangeLine(startBeat: 0.0, duration: 4.0, numberOfVoices: 4, depth: 0.5, flipChannels: true))
    }

    @Test
    func init_setsProperties() {
        let line = DKMFlangeLine(startBeat: 2.0, duration: 4.0, numberOfVoices: 6, depth: 0.75, flipChannels: true)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.numberOfVoices == 6)
        #expect(line.depth == 0.75)
        #expect(line.flipChannels)
    }
}
