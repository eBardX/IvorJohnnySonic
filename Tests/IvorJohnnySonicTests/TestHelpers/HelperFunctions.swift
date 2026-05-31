// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import IvorJohnnySonic

internal func formatScore(_ score: DKMScore) throws -> String? {
    let data = try DKMFormatter().format(score)

    return String(data: data, encoding: .utf8)
}
