// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMPitchesNoteTests {
}

// MARK: -

extension DKMPitchesNoteTests {
    @Test
    func equality() {
        let lhs = DKMPitchesNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, startPitch: 60.0, endPitch: 60.0, instrument: "Piano")
        let rhs = DKMPitchesNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, startPitch: 60.0, endPitch: 60.0, instrument: "Piano")

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMPitchesNote> = [DKMPitchesNote(startBeat: 0.0,
                                                       duration: 1.0,
                                                       volume: 1.0,
                                                       location: 0.0,
                                                       startPitch: 60.0,
                                                       endPitch: 60.0,
                                                       instrument: "Piano"),
                                        DKMPitchesNote(startBeat: 0.0,
                                                       duration: 1.0,
                                                       volume: 1.0,
                                                       location: 0.0,
                                                       startPitch: 60.0,
                                                       endPitch: 60.0,
                                                       instrument: "Piano"),
                                        DKMPitchesNote(startBeat: 0.0,
                                                       duration: 1.0,
                                                       volume: 1.0,
                                                       location: 0.0,
                                                       startPitch: 62.0,
                                                       endPitch: 60.0,
                                                       instrument: "Piano")]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMPitchesNote(startBeat: 0.0, duration: 1.0, volume: 1.0, location: 0.0, startPitch: 60.0, endPitch: 60.0, instrument: "Piano")

        #expect(base != DKMPitchesNote(startBeat: 1.0,
                                       duration: 1.0,
                                       volume: 1.0,
                                       location: 0.0,
                                       startPitch: 60.0,
                                       endPitch: 60.0,
                                       instrument: "Piano"))
        #expect(base != DKMPitchesNote(startBeat: 0.0,
                                       duration: 1.0,
                                       volume: 1.0,
                                       location: 0.0,
                                       startPitch: 60.0,
                                       endPitch: 64.0,
                                       instrument: "Piano"))
    }

    @Test
    func init_negativePitchIsFrequency() {
        let note = DKMPitchesNote(startBeat: 0.0,
                                  duration: 1.0,
                                  volume: 1.0,
                                  location: 0.0,
                                  startPitch: -440.0,
                                  endPitch: -440.0,
                                  instrument: "Piano")

        #expect(note.startPitch == -440.0)
        #expect(note.endPitch == -440.0)
    }

    @Test
    func init_setsProperties() {
        let note = DKMPitchesNote(startBeat: 2.0, duration: 1.5, volume: 0.8, location: 0.5, startPitch: 60.0, endPitch: 67.0, instrument: "Piano")

        #expect(note.startBeat == 2.0)
        #expect(note.duration == 1.5)
        #expect(note.volume == 0.8)
        #expect(note.location == 0.5)
        #expect(note.startPitch == 60.0)
        #expect(note.endPitch == 67.0)
        #expect(note.instrument == "Piano")
    }
}
