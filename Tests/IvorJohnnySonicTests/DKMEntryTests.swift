// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMEntryTests {
}

// MARK: -

extension DKMEntryTests {
    @Test
    func test_initWithMixedArguments() {
        let entry = DKMEntry(command: .filter,
                             arguments: 100.0,
                             "highpass",
                             0.5)

        #expect(entry.command == .filter)
        #expect(entry.arguments.count == 3)

        if case let .double(value) = entry.arguments[0] {
            #expect(value == 100.0)
        } else {
            Issue.record("Expected .double case for first argument")
        }

        if case let .string(value) = entry.arguments[1] {
            #expect(value == "highpass")
        } else {
            Issue.record("Expected .string case for second argument")
        }

        if case let .double(value) = entry.arguments[2] {
            #expect(value == 0.5)
        } else {
            Issue.record("Expected .double case for third argument")
        }
    }

    @Test
    func test_initWithNoArguments() {
        let entry = DKMEntry(command: .end)

        #expect(entry.command == .end)
        #expect(entry.arguments.isEmpty)
    }

    @Test
    func test_initWithSingleArgument() {
        let entry = DKMEntry(command: .soundFileName,
                             arguments: "mysound.wav")

        #expect(entry.command == .soundFileName)
        #expect(entry.arguments.count == 1)
    }
}
