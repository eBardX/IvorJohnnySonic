// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMTuningTests {
}

// MARK: -

extension DKMTuningTests {
    @Test
    func equality() {
        let lhs = DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)
        let rhs = DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMTuning> = [DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864),
                                   DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864),
                                   DKMTuning(primaryInterval: 2.0, notesPerInterval: 19.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMTuning(primaryInterval: 2.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864)

        #expect(base != DKMTuning(primaryInterval: 3.0, notesPerInterval: 12.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864))
        #expect(base != DKMTuning(primaryInterval: 2.0, notesPerInterval: 19.0, pitchConvExponent: 3.0, pitchConvFactor: 1.021974864))
    }

    @Test
    func init_setsProperties() {
        let tuning = DKMTuning(primaryInterval: 3.0, notesPerInterval: 19.0, pitchConvExponent: 4.0, pitchConvFactor: 1.5)

        #expect(tuning.primaryInterval == 3.0)
        #expect(tuning.notesPerInterval == 19.0)
        #expect(tuning.pitchConvExponent == 4.0)
        #expect(tuning.pitchConvFactor == 1.5)
    }
}
