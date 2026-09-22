// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMVocodeNoteTests {
}

// MARK: -

extension DKMVocodeNoteTests {
    @Test
    func equality() {
        let lhs = DKMVocodeNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.0, instrument: "Voice")
        let rhs = DKMVocodeNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.0, instrument: "Voice")

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMVocodeNote> = [DKMVocodeNote(startBeat: 0.0,
                                                     duration: 1.0,
                                                     volume: 1.0,
                                                     location: 0.0,
                                                     pitch: 60.0,
                                                     clipStart: 0.0,
                                                     instrument: "Voice"),
                                       DKMVocodeNote(startBeat: 0.0,
                                                     duration: 1.0,
                                                     volume: 1.0,
                                                     location: 0.0,
                                                     pitch: 60.0,
                                                     clipStart: 0.0,
                                                     instrument: "Voice"),
                                       DKMVocodeNote(startBeat: 0.0,
                                                     duration: 1.0,
                                                     volume: 1.0,
                                                     location: 0.0,
                                                     pitch: 62.0,
                                                     clipStart: 0.0,
                                                     instrument: "Voice")]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMVocodeNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.0, instrument: "Voice")

        #expect(base != DKMVocodeNote(startBeat: 1.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.0, instrument: "Voice"))
        #expect(base != DKMVocodeNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, pitch: 60.0, clipStart: 0.5, instrument: "Voice"))
    }

    @Test
    func init_setsProperties() {
        let note = DKMVocodeNote(startBeat: 2.0, duration: 1.5, volume: 0.8, location: 0.5, pitch: 67.0, clipStart: 0.25, instrument: "Choir")

        #expect(note.startBeat == 2.0)
        #expect(note.duration == 1.5)
        #expect(note.volume == 0.8)
        #expect(note.location == 0.5)
        #expect(note.pitch == 67.0)
        #expect(note.clipStart == 0.25)
        #expect(note.instrument == "Choir")
    }
}
