// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMNormalizerChangeTests {
}

// MARK: -

extension DKMNormalizerChangeTests {
    @Test
    func clampedNegativeDurationMessage() {
        let change = DKMNormalizer.Change.clampedNegativeDuration(commandIndex: 3, duration: -2.0)

        #expect(change.message == "Command 3 had a negative duration (-2.0); clamped to zero")
    }

    @Test
    func clampedNegativeStartBeatMessage() {
        let change = DKMNormalizer.Change.clampedNegativeStartBeat(commandIndex: 2, startBeat: -4.0)

        #expect(change.message == "Command 2 had a negative start beat (-4.0); clamped to zero")
    }

    @Test
    func commandIndex_allCases() {
        #expect(DKMNormalizer.Change.clampedNegativeDuration(commandIndex: 0, duration: -1.0).commandIndex == 0)
        #expect(DKMNormalizer.Change.clampedNegativeStartBeat(commandIndex: 1, startBeat: -1.0).commandIndex == 1)
        #expect(DKMNormalizer.Change.droppedRedundantHaas(commandIndex: 2).commandIndex == 2)
        #expect(DKMNormalizer.Change.droppedRedundantScreenOut(commandIndex: 3).commandIndex == 3)
        #expect(DKMNormalizer.Change.droppedRedundantSoundFileName(commandIndex: 4).commandIndex == 4)
        #expect(DKMNormalizer.Change.droppedRedundantTuning(commandIndex: 5).commandIndex == 5)
        #expect(DKMNormalizer.Change.resolvedContinuationBeat(commandIndex: 6, startBeat: 0.0).commandIndex == 6)
    }

    @Test
    func droppedRedundantHaasMessage() {
        let change = DKMNormalizer.Change.droppedRedundantHaas(commandIndex: 5)

        #expect(change.message == "Command 5 restates the Haas settings already in effect; dropped")
    }

    @Test
    func droppedRedundantScreenOutMessage() {
        let change = DKMNormalizer.Change.droppedRedundantScreenOut(commandIndex: 6)

        #expect(change.message == "Command 6 restates the screen output level already in effect; dropped")
    }

    @Test
    func droppedRedundantSoundFileNameMessage() {
        let change = DKMNormalizer.Change.droppedRedundantSoundFileName(commandIndex: 7)

        #expect(change.message == "Command 7 restates the sound file name already in effect; dropped")
    }

    @Test
    func droppedRedundantTuningMessage() {
        let change = DKMNormalizer.Change.droppedRedundantTuning(commandIndex: 8)

        #expect(change.message == "Command 8 restates the tuning already in effect; dropped")
    }

    @Test
    func hashable() {
        let set: Set<DKMNormalizer.Change> = [.droppedRedundantHaas(commandIndex: 0),
                                              .droppedRedundantHaas(commandIndex: 0),
                                              .droppedRedundantTuning(commandIndex: 0)]

        #expect(set.count == 2)
    }

    @Test
    func inequality_differentCase() {
        #expect(DKMNormalizer.Change.droppedRedundantHaas(commandIndex: 0) != .droppedRedundantTuning(commandIndex: 0))
    }

    @Test
    func resolvedContinuationBeatMessage() {
        let change = DKMNormalizer.Change.resolvedContinuationBeat(commandIndex: 1, startBeat: 4.0)

        #expect(change.message == "Command 1 used a continuation start beat; rewritten to beat 4.0")
    }
}
