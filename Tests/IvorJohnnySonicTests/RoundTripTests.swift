// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import IvorJohnnySonic
import Testing

struct RoundTripTests {
}

// MARK: -

extension RoundTripTests {

    @Test
    func roundTrip_allCommands_coversEveryCommandCase() throws {
        let (score, _) = try DKMParser().parse(loadFixture("AllCommands", extension: "dkm"))

        // `String(describing:)` renders an enum value as `caseName` or
        // `caseName(payload)`, so the leading identifier names the case.
        let covered = Set(score.commands.map { String(String(describing: $0).prefix { $0 != "(" }) })

        let expected: Set = ["chorusLine",
                             "clipMode",
                             "clipNote",
                             "comment",
                             "compressLine",
                             "dynamics",
                             "end",
                             "exclude",
                             "filterLine",
                             "flangeLine",
                             "freqBandAnalyzeLine",
                             "geqLine",
                             "haas",
                             "include",
                             "levelsLine",
                             "mixLine",
                             "pitchesNote",
                             "pulseLine",
                             "reverbLine",
                             "screenOut",
                             "sendBackLine",
                             "showBufferLine",
                             "soundFileName",
                             "statsLine",
                             "tempoLine",
                             "tuning",
                             "vocodeMode",
                             "vocodeNote"]

        #expect(covered == expected)
    }

    @Test
    func roundTrip_allCommands_isByteStableFromSecondGeneration() throws {
        // The first generation is *not* byte-stable: the reader keys sections
        // on `prefix(3).uppercased()` while the writer emits the canonical
        // spelling, and `60` parses to `60.0` and prints as `"60.0"`. From the
        // second generation onward the pipeline is idempotent.
        let data = try loadFixture("AllCommands", extension: "dkm")
        let generation1 = try validateAndFormat(DKMParser().parse(data).0)
        let generation2 = try validateAndFormat(DKMParser().parse(generation1).0)

        #expect(generation1 == generation2)
    }

    @Test
    func roundTrip_allCommands_preservesAST() throws {
        // Compared against the *normalized* AST, not the raw parse: the
        // fixture's one `` `/Levels` `` continuation (a negative start beat)
        // is rewritten to an absolute beat by DKMNormalizer, which now runs
        // as part of formatting.
        let (score, _) = try DKMParser().parse(loadFixture("AllCommands", extension: "dkm"))
        let (normalized, _) = DKMNormalizer().normalize(score)
        let (reparsed, _) = try DKMParser().parse(validateAndFormat(score))

        #expect(reparsed.commands == normalized.commands)
    }

    @Test
    func roundTrip_scoreSample_isByteStableFromSecondGeneration() throws {
        let data = try loadFixture("ScoreSample", extension: "dkm")
        let generation1 = try validateAndFormat(DKMParser().parse(data).0)
        let generation2 = try validateAndFormat(DKMParser().parse(generation1).0)

        #expect(generation1 == generation2)
    }

    @Test
    func roundTrip_scoreSample_preservesAST() throws {
        let (score, _) = try DKMParser().parse(loadFixture("ScoreSample", extension: "dkm"))
        let (reparsed, _) = try DKMParser().parse(validateAndFormat(score))

        #expect(reparsed.commands == score.commands)
    }
}
