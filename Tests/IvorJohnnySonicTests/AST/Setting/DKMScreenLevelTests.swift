// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMScreenLevelTests {
}

// MARK: -

extension DKMScreenLevelTests {
    @Test
    func init_rawValue() {
        #expect(DKMScreenLevel(rawValue: 0) == .quiet)
        #expect(DKMScreenLevel(rawValue: 1) == .medium)
        #expect(DKMScreenLevel(rawValue: 2) == .verbose)
        #expect(DKMScreenLevel(rawValue: 3) == .debug)
        #expect(DKMScreenLevel(rawValue: 4) == nil)
        #expect(DKMScreenLevel(rawValue: -1) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMScreenLevel.quiet.rawValue == 0)
        #expect(DKMScreenLevel.medium.rawValue == 1)
        #expect(DKMScreenLevel.verbose.rawValue == 2)
        #expect(DKMScreenLevel.debug.rawValue == 3)
    }
}
