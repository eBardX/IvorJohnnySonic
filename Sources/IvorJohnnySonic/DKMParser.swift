// © 2026 John Gary Pusey (see LICENSE.md)

public import Foundation

/// A parser that decodes JohnnySonic score data into a ``DKMScore``.
public struct DKMParser {

    // MARK: Public Initializers

    /// Creates a new JohnnySonic parser.
    public init() {
    }
}

// MARK: -

extension DKMParser {

    // MARK: Public Instance Methods

    /// Parses the provided data and returns the decoded JohnnySonic score.
    ///
    /// - Parameter data:   The UTF-8 encoded score data to parse.
    ///
    /// - Returns:  The decoded ``DKMScore``.
    ///
    /// - Throws:   ``DKMParseError`` if the data cannot be parsed as a valid
    ///             JohnnySonic score.
    public func parse(_ data: Data) throws -> DKMScore {
        guard let string = String(data: data, encoding: .utf8)
        else { throw DKMParseError.dataConversionFailed }

        let lines = string.split(omittingEmptySubsequences: false) {
            $0 == "\n" || $0 == "\r"
        }

        var reader = Reader(lines: lines)

        return try reader.readScore()
    }
}

// MARK: - Sendable

extension DKMParser: Sendable {
}
