// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMFBAChannelTests {
}

// MARK: -

extension DKMFBAChannelTests {
    @Test
    func init_rawValue() {
        #expect(DKMFBAChannel(rawValue: -1) == .combined)
        #expect(DKMFBAChannel(rawValue: 0) == .left)
        #expect(DKMFBAChannel(rawValue: 1) == .right)
        #expect(DKMFBAChannel(rawValue: 2) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMFBAChannel.combined.rawValue == -1)
        #expect(DKMFBAChannel.left.rawValue == 0)
        #expect(DKMFBAChannel.right.rawValue == 1)
    }
}
