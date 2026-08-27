// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMValidator {

    // MARK: Public Nested Types

    /// An issue found when validating a ``DKMScore`` against the reference
    /// implementation’s parameter constraints.
    public enum Issue {

        /// A command’s beat exceeds the maximum size of the beat-time
        /// lookup table.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the offending beat.
        case beatExceedsTableSize(commandIndex: Int, beat: Double)

        /// A clip note has no preceding clip mode command to supply its clip.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``.
        case clipNoteWithoutMode(commandIndex: Int)

        /// A `` `/GEQ` `` line has no adjacent `` `/GEQ` `` line to complete
        /// its segment.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``.
        case incompleteGraphicEQSegment(commandIndex: Int)

        /// A `` `/GEQ` `` line specifies more band gains than the reference
        /// implementation reads.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the number of band
        /// gains specified.
        case invalidBandGainCount(commandIndex: Int, count: Int)

        /// A command has a non-finite (`NaN` or infinite) value for a
        /// parameter.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the name of the
        /// offending parameter.
        case nonFiniteParameter(commandIndex: Int, parameter: String)

        /// A command has a duration that is zero or negative.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the offending
        /// duration.
        case nonPositiveDuration(commandIndex: Int, duration: Double)

        /// A `` `/Tempo` `` line has a tempo that is zero or negative.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the offending tempo.
        case nonPositiveTempo(commandIndex: Int, tempo: Double)

        /// A command has a parameter whose value is outside the range the
        /// reference implementation accepts without inventing a replacement.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, the name of the
        /// offending parameter, and its value.
        case parameterOutOfRange(commandIndex: Int, parameter: String, value: Double)

        /// A command has a name or path that the formatter cannot write.
        ///
        /// The associated values are the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``, and the offending name.
        case unwritableName(commandIndex: Int, name: String)

        /// A vocode note has no preceding vocode mode command to supply its
        /// clip and vocoder parameters.
        ///
        /// The associated value is the index of the command in the score
        /// passed to ``DKMValidator/validate(_:)``.
        case vocodeNoteWithoutMode(commandIndex: Int)
    }
}

// MARK: -

extension DKMValidator.Issue {

    // MARK: Public Instance Properties

    /// The zero-based index of the command, in the score passed to
    /// ``DKMValidator/validate(_:)``, that this issue applies to.
    public var commandIndex: Int? {
        switch self {
        case let .beatExceedsTableSize(commandIndex, _),
             let .clipNoteWithoutMode(commandIndex),
             let .incompleteGraphicEQSegment(commandIndex),
             let .invalidBandGainCount(commandIndex, _),
             let .nonFiniteParameter(commandIndex, _),
             let .nonPositiveDuration(commandIndex, _),
             let .nonPositiveTempo(commandIndex, _),
             let .parameterOutOfRange(commandIndex, _, _),
             let .unwritableName(commandIndex, _),
             let .vocodeNoteWithoutMode(commandIndex):
            commandIndex
        }
    }

    /// A human-readable description of this issue.
    public var message: String {
        switch self {
        case let .beatExceedsTableSize(commandIndex, beat):
            "Command \(commandIndex) has a beat (\(beat)) that exceeds the maximum table size of 8192"

        case let .clipNoteWithoutMode(commandIndex):
            "Command \(commandIndex) is a clip note with no preceding clip mode command"

        case let .incompleteGraphicEQSegment(commandIndex):
            "Command \(commandIndex) is a GEQ line with no adjacent GEQ line to complete its segment"

        case let .invalidBandGainCount(commandIndex, count):
            "Command \(commandIndex) specifies \(count) band gain(s), which exceeds the maximum of 30"

        case let .nonFiniteParameter(commandIndex, parameter):
            "Command \(commandIndex) has a non-finite value for \(parameter)"

        case let .nonPositiveDuration(commandIndex, duration):
            "Command \(commandIndex) has a non-positive duration (\(duration))"

        case let .nonPositiveTempo(commandIndex, tempo):
            "Command \(commandIndex) has a non-positive tempo (\(tempo))"

        case let .parameterOutOfRange(commandIndex, parameter, value):
            "Command \(commandIndex) has \(parameter) (\(value)) out of range"

        case let .unwritableName(commandIndex, name):
            "Command \(commandIndex) has an unwritable name (\"\(name)\")"

        case let .vocodeNoteWithoutMode(commandIndex):
            "Command \(commandIndex) is a vocode note with no preceding vocode mode command"
        }
    }
}

// MARK: - Equatable

extension DKMValidator.Issue: Equatable {
}

// MARK: - Hashable

extension DKMValidator.Issue: Hashable {
}

// MARK: - Sendable

extension DKMValidator.Issue: Sendable {
}
