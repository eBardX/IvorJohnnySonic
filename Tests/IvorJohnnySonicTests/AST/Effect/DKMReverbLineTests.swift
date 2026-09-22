// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMReverbLineTests {
}

// MARK: -

extension DKMReverbLineTests {
    @Test
    func equality() {
        let lhs = DKMReverbLine(startBeat: 0.0,
                                duration: 4.0,
                                direction: .forward,
                                size: .medium,
                                reverbTime: 1.5,
                                combFilterDryGain: 0.5,
                                xTalkFactor: 0.3,
                                wetness: 0.4)
        let rhs = DKMReverbLine(startBeat: 0.0,
                                duration: 4.0,
                                direction: .forward,
                                size: .medium,
                                reverbTime: 1.5,
                                combFilterDryGain: 0.5,
                                xTalkFactor: 0.3,
                                wetness: 0.4)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMReverbLine> = [DKMReverbLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     direction: .forward,
                                                     size: .medium,
                                                     reverbTime: 1.5,
                                                     combFilterDryGain: 0.5,
                                                     xTalkFactor: 0.3,
                                                     wetness: 0.4),
                                       DKMReverbLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     direction: .forward,
                                                     size: .medium,
                                                     reverbTime: 1.5,
                                                     combFilterDryGain: 0.5,
                                                     xTalkFactor: 0.3,
                                                     wetness: 0.4),
                                       DKMReverbLine(startBeat: 0.0,
                                                     duration: 4.0,
                                                     direction: .backward,
                                                     size: .medium,
                                                     reverbTime: 1.5,
                                                     combFilterDryGain: 0.5,
                                                     xTalkFactor: 0.3,
                                                     wetness: 0.4)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMReverbLine(startBeat: 0.0,
                                 duration: 4.0,
                                 direction: .forward,
                                 size: .medium,
                                 reverbTime: 1.5,
                                 combFilterDryGain: 0.5,
                                 xTalkFactor: 0.3,
                                 wetness: 0.4)

        #expect(base != DKMReverbLine(startBeat: 1.0,
                                      duration: 4.0,
                                      direction: .forward,
                                      size: .medium,
                                      reverbTime: 1.5,
                                      combFilterDryGain: 0.5,
                                      xTalkFactor: 0.3,
                                      wetness: 0.4))
        #expect(base != DKMReverbLine(startBeat: 0.0,
                                      duration: 4.0,
                                      direction: .forward,
                                      size: .large,
                                      reverbTime: 1.5,
                                      combFilterDryGain: 0.5,
                                      xTalkFactor: 0.3,
                                      wetness: 0.4))
    }

    @Test
    func init_setsProperties() {
        let line = DKMReverbLine(startBeat: 2.0,
                                 duration: 4.0,
                                 direction: .backward,
                                 size: .small,
                                 reverbTime: 0.8,
                                 combFilterDryGain: 0.2,
                                 xTalkFactor: 0.1,
                                 wetness: 0.9)

        #expect(line.startBeat == 2.0)
        #expect(line.duration == 4.0)
        #expect(line.direction == .backward)
        #expect(line.size == .small)
        #expect(line.reverbTime == 0.8)
        #expect(line.combFilterDryGain == 0.2)
        #expect(line.xTalkFactor == 0.1)
        #expect(line.wetness == 0.9)
    }
}
