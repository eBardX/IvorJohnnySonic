// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import IvorJohnnySonic

internal func formatScore(_ score: DKMScore) throws -> String? {
    let data = try DKMFormatter().format(score)

    return String(data: data, encoding: .utf8)
}

internal func parseScore(_ string: String) throws -> DKMScore {
    let data = Data(string.utf8)

    return try DKMParser().parse(data)
}
