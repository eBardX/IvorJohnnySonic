// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import IvorJohnnySonic

internal func formatScore(_ score: DKMScore) throws -> String? {
    let data = try validateAndFormat(score)

    return String(data: data, encoding: .utf8)
}

internal func loadFixture(_ name: String,
                          extension ext: String) throws -> Data {
    let url = Bundle.module.url(forResource: name, withExtension: ext)!  // swiftlint:disable:this force_unwrapping

    return try Data(contentsOf: url)
}

internal func parseScore(_ string: String) throws -> DKMScore {
    try parseScoreWithDiagnostics(string).0
}

internal func parseScoreWithDiagnostics(_ string: String) throws -> (DKMScore, [DKMParser.Diagnostic]) {
    let data = Data(string.utf8)

    return try DKMParser().parse(data)
}

internal func validateAndFormat(_ score: DKMScore) throws -> Data {
    try DKMFormatter().format(validateScore(score))
}

internal func validateScore(_ score: DKMScore) throws -> DKMScore {
    let (normalized, _) = DKMNormalizer().normalize(score)
    let (validated, issues) = try DKMValidator().validate(normalized)

    guard issues.isEmpty
    else { throw UnexpectedValidationIssues(issues: issues) }

    return validated
}
