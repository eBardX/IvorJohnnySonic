// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMMixLineTests {
}

// MARK: -

extension DKMMixLineTests {
    @Test
    func equality() {
        let lhs = DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0)
        let rhs = DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMMixLine> = [DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0),
                                    DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0),
                                    DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: false, sign: 1.0, timeOffset: 0.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0)

        #expect(base != DKMMixLine(startBeat: 1.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: 1.0, timeOffset: 0.0))
        #expect(base != DKMMixLine(startBeat: 0.0, duration: 4.0, gainLossdB: 0.0, keepSoundBuffer: true, sign: -1.0, timeOffset: 0.0))
    }

    @Test
    func init_setsProperties() {
        let line = DKMMixLine(startBeat: 2.0, duration: 4.0, gainLossdB: -3.0, keepSoundBuffer: false, sign: -1.0, timeOffset: 0.5)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.gainLossdB == -3.0)
        #expect(!line.keepSoundBuffer)
        #expect(line.sign == -1.0)
        #expect(line.timeOffset == 0.5)
    }
}
