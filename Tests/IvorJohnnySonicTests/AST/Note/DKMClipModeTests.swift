// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMClipModeTests {
}

// MARK: -

extension DKMClipModeTests {
    @Test
    func equality() {
        let lhs = DKMClipMode(channel: .left, name: "Drums")
        let rhs = DKMClipMode(channel: .left, name: "Drums")

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMClipMode> = [DKMClipMode(channel: .left, name: "Drums"),
                                     DKMClipMode(channel: .left, name: "Drums"),
                                     DKMClipMode(channel: .right, name: "Drums")]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMClipMode(channel: .left, name: "Drums")

        #expect(base != DKMClipMode(channel: .right, name: "Drums"))
        #expect(base != DKMClipMode(channel: .left, name: "Bass"))
    }

    @Test
    func init_setsProperties() {
        let mode = DKMClipMode(channel: .right, name: "Vocals")

        #expect(mode.channel == .right)
        #expect(mode.name == "Vocals")
    }
}
