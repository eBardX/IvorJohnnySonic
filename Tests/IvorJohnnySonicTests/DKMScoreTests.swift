// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMScoreTests {
}

// MARK: -

extension DKMScoreTests {
    @Test
    func test_initWithEmptyEntries() {
        let score = DKMScore(entries: [])

        #expect(score.entries.isEmpty)
    }

    @Test
    func test_initWithMultipleEntries() {
        let entries = [DKMEntry(command: .soundFileName,
                                arguments: "test.wav"),
                       DKMEntry(command: .tempo,
                                arguments: 120.0),
                       DKMEntry(command: .end)]
        let score = DKMScore(entries: entries)

        #expect(score.entries.count == 3)
        #expect(score.entries[0].command == .soundFileName)
        #expect(score.entries[1].command == .tempo)
        #expect(score.entries[2].command == .end)
    }

    @Test
    func test_initWithSingleEntry() {
        let entry = DKMEntry(command: .end)
        let score = DKMScore(entries: [entry])

        #expect(score.entries.count == 1)
        #expect(score.entries[0].command == .end)
    }
}
