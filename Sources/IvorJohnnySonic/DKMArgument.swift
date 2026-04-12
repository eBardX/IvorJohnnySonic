// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// An argument to a Johnny Sonic command.
public enum DKMArgument {
    /// A double-precision floating-point value argument.
    case double(Double)

    /// A string value argument.
    case string(String)
}

// MARK: - ExpressibleByFloatLiteral

extension DKMArgument: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension DKMArgument: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

// MARK: - Sendable

extension DKMArgument: Sendable {
}
