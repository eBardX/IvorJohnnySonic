// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMClipChannelTests {
}

// MARK: -

extension DKMClipChannelTests {
    @Test
    func init_rawValue() {
        #expect(DKMClipChannel(rawValue: 0) == .left)
        #expect(DKMClipChannel(rawValue: 1) == .right)
        #expect(DKMClipChannel(rawValue: 2) == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMClipChannel.left.rawValue == 0)
        #expect(DKMClipChannel.right.rawValue == 1)
    }
}
