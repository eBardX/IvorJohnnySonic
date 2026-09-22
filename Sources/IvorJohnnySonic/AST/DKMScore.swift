// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A JohnnySonic score consisting of an ordered list of commands.
public struct DKMScore {

    // MARK: Public Initializers

    /// Creates a new JohnnySonic score with the provided commands.
    ///
    /// The returned score has both ``isNormalized`` and ``isValidated`` set
    /// to `false`. Call ``DKMNormalizer/normalize(_:)`` and then
    /// ``DKMValidator/validate(_:)`` before ``DKMFormatter/format(_:)``.
    ///
    /// - Parameter commands:   The commands in the score.
    public init(commands: [DKMCommand]) {
        self.init(commands: commands,
                  isNormalized: false,
                  isValidated: false)
    }

    // MARK: Public Instance Properties

    /// The commands in this score.
    public let commands: [DKMCommand]

    /// A Boolean value indicating whether this score has been normalized via
    /// ``DKMNormalizer/normalize(_:)``.
    ///
    /// `false` for scores produced by ``init(commands:)`` until
    /// ``DKMNormalizer/normalize(_:)`` is called; `true` for all scores
    /// returned by ``DKMNormalizer/normalize(_:)``.
    public let isNormalized: Bool

    /// A Boolean value indicating whether this score has been validated via
    /// ``DKMValidator/validate(_:)``.
    ///
    /// `false` until a successful ``DKMValidator/validate(_:)`` call returns
    /// a copy with this flag set to `true`.
    public let isValidated: Bool

    // MARK: Internal Initializers

    internal init(commands: [DKMCommand],
                  isNormalized: Bool,
                  isValidated: Bool) {
        self.commands = commands
        self.isNormalized = isNormalized
        self.isValidated = isValidated
    }
}

// MARK: - Equatable

extension DKMScore: Equatable {

    // MARK: Public Type Methods

    /// Returns a Boolean value indicating whether two scores are equal.
    ///
    /// Equality compares only ``commands``; ``isNormalized`` and
    /// ``isValidated`` are intentionally excluded because they are pipeline
    /// metadata, not content.
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.commands == rhs.commands
    }
}

// MARK: - Hashable

extension DKMScore: Hashable {

    // MARK: Public Instance Methods

    /// Hashes ``commands``; ``isNormalized`` and ``isValidated`` are
    /// excluded, matching `==`.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(commands)
    }
}

// MARK: - Sendable

extension DKMScore: Sendable {
}
