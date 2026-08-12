// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMChannelTests {
}

// MARK: -

extension DKMChannelTests {
    @Test
    func init_rawValue() {
        #expect(DKMChannel(rawValue: "B") == .both)
        #expect(DKMChannel(rawValue: "L") == .left)
        #expect(DKMChannel(rawValue: "R") == .right)
        #expect(DKMChannel(rawValue: "X") == nil)
    }

    @Test
    func rawValue() {
        #expect(DKMChannel.both.rawValue == "B")
        #expect(DKMChannel.left.rawValue == "L")
        #expect(DKMChannel.right.rawValue == "R")
    }
}
