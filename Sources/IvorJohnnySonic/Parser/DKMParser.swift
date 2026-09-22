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

    /// Parses the provided data and returns the decoded JohnnySonic score
    /// along with any diagnostic messages produced during recovery.
    ///
    /// - Parameter data:   The UTF-8 encoded score data to parse.
    ///
    /// - Returns:  A tuple containing the decoded ``DKMScore`` and an array of
    ///             ``DKMParser/Diagnostic`` values describing any recoveries
    ///             performed.
    ///
    /// - Throws:   ``DKMParser/Error`` if the data cannot be parsed as a valid
    ///             JohnnySonic score.
    public func parse(_ data: Data) throws(DKMParser.Error) -> (DKMScore, [Diagnostic]) {
        guard let string = String(data: data, encoding: .utf8)
        else { throw DKMParser.Error.dataConversionFailed }

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
