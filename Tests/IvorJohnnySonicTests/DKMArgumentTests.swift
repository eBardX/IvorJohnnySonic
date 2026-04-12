// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMArgumentTests {
}

// MARK: -

extension DKMArgumentTests {
    @Test
    func test_doubleCase() {
        let argument = DKMArgument.double(3.14)

        if case let .double(value) = argument {
            #expect(value == 3.14)
        } else {
            Issue.record("Expected .double case")
        }
    }

    @Test
    func test_expressibleByFloatLiteral() {
        let argument: DKMArgument = 2.71

        if case let .double(value) = argument {
            #expect(value == 2.71)
        } else {
            Issue.record("Expected .double case")
        }
    }

    @Test
    func test_expressibleByStringLiteral() {
        let argument: DKMArgument = "hello"

        if case let .string(value) = argument {
            #expect(value == "hello")
        } else {
            Issue.record("Expected .string case")
        }
    }

    @Test
    func test_stringCase() {
        let argument = DKMArgument.string("test")

        if case let .string(value) = argument {
            #expect(value == "test")
        } else {
            Issue.record("Expected .string case")
        }
    }
}
