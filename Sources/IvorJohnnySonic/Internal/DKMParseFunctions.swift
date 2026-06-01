// © 2026 John Gary Pusey (see LICENSE.md)

private import XestiTools

// MARK: Internal Functions

internal func parseBool(_ input: Substring) -> Bool? {
    switch input {
    case "0":
         false

    case "1":
         true

    default:
         nil
    }
}

internal func parseChannel(_ input: Substring) -> DKMChannel? {
    DKMChannel(rawValue: String(input))
}

internal func parseClipChannel(_ input: Substring) -> DKMClipChannel? {
    guard let intValue = Int(input),
          let value = DKMClipChannel(rawValue: intValue)
    else { return nil }

    return value
}

internal func parseDouble(_ input: Substring) -> Double? {
    Double(input)
}

internal func parseFBABuffer(_ input: Substring) -> DKMFBABuffer? {
    DKMFBABuffer(rawValue: String(input))
}

internal func parseFBAChannel(_ input: Substring) -> DKMFBAChannel? {
    guard let intValue = Int(input)
    else { return nil }

    return DKMFBAChannel(rawValue: intValue)
}

internal func parseFilterType(_ input: Substring) -> DKMFilterType? {
    guard let intValue = Int(input)
    else { return nil }

    return DKMFilterType(rawValue: intValue)
}

internal func parseInt(_ input: Substring) -> Int? {
    Int(input)
}

internal func parseReverbDirection(_ input: Substring) -> DKMReverbDirection? {
    guard let intValue = Int(input)
    else { return nil }

    return DKMReverbDirection(rawValue: intValue)
}

internal func parseReverbSize(_ input: Substring) -> DKMReverbSize? {
    guard let intValue = Int(input)
    else { return nil }

    return DKMReverbSize(rawValue: intValue)
}

internal func parseScreenLevel(_ input: Substring) -> DKMScreenLevel? {
    guard let intValue = Int(input)
    else { return nil }

    return DKMScreenLevel(rawValue: intValue)
}

internal func parseString(_ input: Substring) -> String? {
    String(input)
}
