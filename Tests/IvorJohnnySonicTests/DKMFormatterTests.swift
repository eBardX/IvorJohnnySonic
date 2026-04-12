// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import IvorJohnnySonic
import Testing

struct DKMFormatterTests {
}

// MARK: -

extension DKMFormatterTests {
    @Test
    func test_formatCommentWithArguments() throws {
        let score = DKMScore(entries: [DKMEntry(command: .comment,
                                                arguments: " This is a comment")])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "! This is a comment\n")
    }

    @Test
    func test_formatCommentWithNoArguments() throws {
        let score = DKMScore(entries: [DKMEntry(command: .comment)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "!\n")
    }

    @Test
    func test_formatCommandWithMultipleArguments() throws {
        let score = DKMScore(entries: [DKMEntry(command: .filter,
                                                arguments: 100.0,
                                                200.0,
                                                0.5)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/Filter\n100.0 200.0 0.5\n")
    }

    @Test
    func test_formatCommandWithNoArguments() throws {
        let score = DKMScore(entries: [DKMEntry(command: .end)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/End\n")
    }

    @Test
    func test_formatCommandWithSingleArgument() throws {
        let score = DKMScore(entries: [DKMEntry(command: .soundFileName,
                                                arguments: "mysound.wav")])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/SFN\nmysound.wav\n")
    }

    @Test
    func test_formatCommentBetweenSameCommands() throws {
        let score = DKMScore(entries: [DKMEntry(command: .filter,
                                                arguments: 100.0),
                                       DKMEntry(command: .comment,
                                                arguments: " interleaved"),
                                       DKMEntry(command: .filter,
                                                arguments: 200.0)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/Filter\n100.0\n! interleaved\n200.0\n")
    }

    @Test
    func test_formatConsecutiveSameCommands() throws {
        let score = DKMScore(entries: [DKMEntry(command: .filter,
                                                arguments: 100.0),
                                       DKMEntry(command: .filter,
                                                arguments: 200.0)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/Filter\n100.0\n200.0\n")
    }

    @Test
    func test_formatDifferentCommands() throws {
        let score = DKMScore(entries: [DKMEntry(command: .filter,
                                                arguments: 100.0),
                                       DKMEntry(command: .reverb,
                                                arguments: 0.5)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "/Filter\n100.0\n/Reverb\n0.5\n")
    }

    @Test
    func test_formatEmptyScore() throws {
        let score = DKMScore(entries: [])
        let data = try DKMFormatter().format(score)

        #expect(data.isEmpty)
    }

    @Test
    func test_formatMixedEntries() throws {
        let score = DKMScore(entries: [DKMEntry(command: .comment,
                                                arguments: " Header"),
                                       DKMEntry(command: .soundFileName,
                                                arguments: "test.wav"),
                                       DKMEntry(command: .tempo,
                                                arguments: 120.0),
                                       DKMEntry(command: .end)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "! Header\n/SFN\ntest.wav\n/Tempo\n120.0\n/End\n")
    }

    @Test
    func test_formatMultipleComments() throws {
        let score = DKMScore(entries: [DKMEntry(command: .comment,
                                                arguments: " First"),
                                       DKMEntry(command: .comment,
                                                arguments: " Second")])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result == "! First\n! Second\n")
    }

    @Test
    func test_formatRejectsStringArgumentWithNewline() throws {
        let score = DKMScore(entries: [DKMEntry(command: .soundFileName,
                                                arguments: "bad\nvalue")])

        #expect(throws: DKMFormatError.self) {
            try DKMFormatter().format(score)
        }
    }

    @Test
    func test_formatReturnsValidUTF8Data() throws {
        let score = DKMScore(entries: [DKMEntry(command: .end)])
        let data = try DKMFormatter().format(score)
        let result = String(data: data,
                            encoding: .utf8)

        #expect(result != nil)
    }
}
