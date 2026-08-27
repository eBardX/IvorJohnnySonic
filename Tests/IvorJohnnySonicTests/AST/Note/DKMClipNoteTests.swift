// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMClipNoteTests {
}

// MARK: -

extension DKMClipNoteTests {
    @Test
    func equality() {
        let lhs = DKMClipNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Drums")
        let rhs = DKMClipNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Drums")

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMClipNote> = [DKMClipNote(startBeat: 0.0,
                                                 duration: 1.0,
                                                 volume: 1.0,
                                                 location: 0.0,
                                                 clipStart: 0.0,
                                                 clipRate: 1.0,
                                                 instrument: "Drums"),
                                     DKMClipNote(startBeat: 0.0,
                                                 duration: 1.0,
                                                 volume: 1.0,
                                                 location: 0.0,
                                                 clipStart: 0.0,
                                                 clipRate: 1.0,
                                                 instrument: "Drums"),
                                     DKMClipNote(startBeat: 0.0,
                                                 duration: 1.0,
                                                 volume: 1.0,
                                                 location: 0.0,
                                                 clipStart: 0.0,
                                                 clipRate: 1.0,
                                                 instrument: "Bass")]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMClipNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Drums")

        #expect(base != DKMClipNote(startBeat: 1.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Drums"))
        #expect(base != DKMClipNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, clipStart: 0.0, clipRate: 1.0, instrument: "Bass"))
    }

    @Test
    func init_setsProperties() {
        let note = DKMClipNote(startBeat: 2.0, duration: 1.5, volume: 0.8, location: -0.5, clipStart: 0.25, clipRate: 1.5, instrument: "Vocals")

        #expect(note.startBeat == 2.0)
        #expect(note.duration == 1.5)
        #expect(note.volume == 0.8)
        #expect(note.location == -0.5)
        #expect(note.clipStart == 0.25)
        #expect(note.clipRate == 1.5)
        #expect(note.instrument == "Vocals")
    }
}
