// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMNormalizer {

    // MARK: Public Nested Types

    /// A change applied when normalizing a ``DKMScore`` to canonical form.
    public enum Change {

        /// A command had a negative duration; it was clamped to zero.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``, and the duration
        /// before clamping.
        case clampedNegativeDuration(commandIndex: Int, duration: Double)

        /// A command had a negative start beat; it was clamped to zero.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``, and the start beat
        /// before clamping.
        case clampedNegativeStartBeat(commandIndex: Int, startBeat: Double)

        /// A Haas command restated the settings already in effect; it was
        /// dropped.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``.
        case droppedRedundantHaas(commandIndex: Int)

        /// A screen-output command restated the level already in effect; it
        /// was dropped.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``.
        case droppedRedundantScreenOut(commandIndex: Int)

        /// A sound-file-name command restated the name already in effect; it
        /// was dropped.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``.
        case droppedRedundantSoundFileName(commandIndex: Int)

        /// A tuning command restated the tuning already in effect; it was
        /// dropped.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``.
        case droppedRedundantTuning(commandIndex: Int)

        /// A levels line used the continuation start beat (a negative
        /// value); it was rewritten to the beat the preceding levels line
        /// ended at.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMNormalizer/normalize(_:)``, and the start beat it
        /// was rewritten to.
        case resolvedContinuationBeat(commandIndex: Int, startBeat: Double)
    }
}

// MARK: -

extension DKMNormalizer.Change {

    // MARK: Public Instance Properties

    /// The zero-based index of the command, in the score passed to
    /// ``DKMNormalizer/normalize(_:)``, that this change applies to.
    ///
    /// Normalization can drop commands, so this index is only meaningful
    /// against the *input* score — it does not necessarily locate the
    /// corresponding command in the normalized output.
    public var commandIndex: Int? {
        switch self {
        case let .clampedNegativeDuration(commandIndex, _),
             let .clampedNegativeStartBeat(commandIndex, _),
             let .droppedRedundantHaas(commandIndex),
             let .droppedRedundantScreenOut(commandIndex),
             let .droppedRedundantSoundFileName(commandIndex),
             let .droppedRedundantTuning(commandIndex),
             let .resolvedContinuationBeat(commandIndex, _):
            commandIndex
        }
    }

    /// A human-readable description of this change.
    public var message: String {
        switch self {
        case let .clampedNegativeDuration(commandIndex, duration):
            "Command \(commandIndex) had a negative duration (\(duration)); clamped to zero"

        case let .clampedNegativeStartBeat(commandIndex, startBeat):
            "Command \(commandIndex) had a negative start beat (\(startBeat)); clamped to zero"

        case let .droppedRedundantHaas(commandIndex):
            "Command \(commandIndex) restates the Haas settings already in effect; dropped"

        case let .droppedRedundantScreenOut(commandIndex):
            "Command \(commandIndex) restates the screen output level already in effect; dropped"

        case let .droppedRedundantSoundFileName(commandIndex):
            "Command \(commandIndex) restates the sound file name already in effect; dropped"

        case let .droppedRedundantTuning(commandIndex):
            "Command \(commandIndex) restates the tuning already in effect; dropped"

        case let .resolvedContinuationBeat(commandIndex, startBeat):
            "Command \(commandIndex) used a continuation start beat; rewritten to beat \(startBeat)"
        }
    }
}

// MARK: - Equatable

extension DKMNormalizer.Change: Equatable {
}

// MARK: - Hashable

extension DKMNormalizer.Change: Hashable {
}

// MARK: - Sendable

extension DKMNormalizer.Change: Sendable {
}
