// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMVocodeModeTests {
}

// MARK: -

extension DKMVocodeModeTests {
    @Test
    func equality() {
        let lhs = DKMVocodeMode(channel: .left,
                                name: "Voice",
                                clipRate: 1.0,
                                maxHarm: 0,
                                slope: 0.0,
                                bassBoost: 0.0,
                                dynExponent: 1.0,
                                shiftN: 0,
                                peakReduction: 0.0)
        let rhs = DKMVocodeMode(channel: .left,
                                name: "Voice",
                                clipRate: 1.0,
                                maxHarm: 0,
                                slope: 0.0,
                                bassBoost: 0.0,
                                dynExponent: 1.0,
                                shiftN: 0,
                                peakReduction: 0.0)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMVocodeMode> = [DKMVocodeMode(channel: .left,
                                                     name: "Voice",
                                                     clipRate: 1.0,
                                                     maxHarm: 0,
                                                     slope: 0.0,
                                                     bassBoost: 0.0,
                                                     dynExponent: 1.0,
                                                     shiftN: 0,
                                                     peakReduction: 0.0),
                                       DKMVocodeMode(channel: .left,
                                                     name: "Voice",
                                                     clipRate: 1.0,
                                                     maxHarm: 0,
                                                     slope: 0.0,
                                                     bassBoost: 0.0,
                                                     dynExponent: 1.0,
                                                     shiftN: 0,
                                                     peakReduction: 0.0),
                                       DKMVocodeMode(channel: .right,
                                                     name: "Voice",
                                                     clipRate: 1.0,
                                                     maxHarm: 0,
                                                     slope: 0.0,
                                                     bassBoost: 0.0,
                                                     dynExponent: 1.0,
                                                     shiftN: 0,
                                                     peakReduction: 0.0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMVocodeMode(channel: .left,
                                 name: "Voice",
                                 clipRate: 1.0,
                                 maxHarm: 0,
                                 slope: 0.0,
                                 bassBoost: 0.0,
                                 dynExponent: 1.0,
                                 shiftN: 0,
                                 peakReduction: 0.0)

        #expect(base != DKMVocodeMode(channel: .right,
                                      name: "Voice",
                                      clipRate: 1.0,
                                      maxHarm: 0,
                                      slope: 0.0,
                                      bassBoost: 0.0,
                                      dynExponent: 1.0,
                                      shiftN: 0,
                                      peakReduction: 0.0))
        #expect(base != DKMVocodeMode(channel: .left,
                                      name: "Voice",
                                      clipRate: 1.0,
                                      maxHarm: 1,
                                      slope: 0.0,
                                      bassBoost: 0.0,
                                      dynExponent: 1.0,
                                      shiftN: 0,
                                      peakReduction: 0.0))
    }

    @Test
    func init_setsProperties() {
        let mode = DKMVocodeMode(channel: .right,
                                 name: "Choir",
                                 clipRate: 0.5,
                                 maxHarm: 4,
                                 slope: -3.0,
                                 bassBoost: 6.0,
                                 dynExponent: 2.0,
                                 shiftN: -16,
                                 peakReduction: 3.0)

        #expect(mode.channel == .right)
        #expect(mode.name == "Choir")
        #expect(mode.clipRate == 0.5)
        #expect(mode.maxHarm == 4)
        #expect(mode.slope == -3.0)
        #expect(mode.bassBoost == 6.0)
        #expect(mode.dynExponent == 2.0)
        #expect(mode.shiftN == -16)
        #expect(mode.peakReduction == 3.0)
    }
}
