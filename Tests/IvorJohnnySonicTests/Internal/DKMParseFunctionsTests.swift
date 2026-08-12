// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMParseFunctionsTests {
}

// MARK: -

extension DKMParseFunctionsTests {
    @Test
    func parseBool_invalid() {
        #expect(parseBool("2") == nil)
        #expect(parseBool("true") == nil)
        #expect(parseBool("") == nil)
    }

    @Test
    func parseBool_valid() {
        #expect(parseBool("0") == false)
        #expect(parseBool("1") == true)
    }

    @Test
    func parseChannel_invalid() {
        #expect(parseChannel("X") == nil)
        #expect(parseChannel("") == nil)
    }

    @Test
    func parseChannel_valid() {
        #expect(parseChannel("B") == .both)
        #expect(parseChannel("L") == .left)
        #expect(parseChannel("R") == .right)
    }

    @Test
    func parseClipChannel_invalid() {
        #expect(parseClipChannel("2") == nil)
        #expect(parseClipChannel("foo") == nil)
    }

    @Test
    func parseClipChannel_valid() {
        #expect(parseClipChannel("0") == .left)
        #expect(parseClipChannel("1") == .right)
    }

    @Test
    func parseDouble_invalid() {
        #expect(parseDouble("foo") == nil)
    }

    @Test
    func parseDouble_valid() {
        #expect(parseDouble("1.5") == 1.5)
        #expect(parseDouble("-2.25") == -2.25)
    }

    @Test
    func parseFBABuffer_invalid() {
        #expect(parseFBABuffer("X") == nil)
    }

    @Test
    func parseFBABuffer_valid() {
        #expect(parseFBABuffer("M") == .mix)
        #expect(parseFBABuffer("S") == .sound)
    }

    @Test
    func parseFBAChannel_invalid() {
        #expect(parseFBAChannel("2") == nil)
        #expect(parseFBAChannel("foo") == nil)
    }

    @Test
    func parseFBAChannel_valid() {
        #expect(parseFBAChannel("-1") == .combined)
        #expect(parseFBAChannel("0") == .left)
        #expect(parseFBAChannel("1") == .right)
    }

    @Test
    func parseFilterType_invalid() {
        #expect(parseFilterType("0") == nil)
        #expect(parseFilterType("foo") == nil)
    }

    @Test
    func parseFilterType_valid() {
        #expect(parseFilterType("5") == .butterworthBandpass)
    }

    @Test
    func parseInt_invalid() {
        #expect(parseInt("foo") == nil)
        #expect(parseInt("1.5") == nil)
    }

    @Test
    func parseInt_valid() {
        #expect(parseInt("42") == 42)
        #expect(parseInt("-7") == -7)
    }

    @Test
    func parseReverbDirection_invalid() {
        #expect(parseReverbDirection("0") == nil)
        #expect(parseReverbDirection("foo") == nil)
    }

    @Test
    func parseReverbDirection_valid() {
        #expect(parseReverbDirection("-1") == .backward)
        #expect(parseReverbDirection("1") == .forward)
    }

    @Test
    func parseReverbSize_invalid() {
        #expect(parseReverbSize("0") == nil)
        #expect(parseReverbSize("foo") == nil)
    }

    @Test
    func parseReverbSize_valid() {
        #expect(parseReverbSize("1") == .small)
        #expect(parseReverbSize("2") == .medium)
        #expect(parseReverbSize("3") == .large)
    }

    @Test
    func parseScreenLevel_invalid() {
        #expect(parseScreenLevel("-1") == nil)
        #expect(parseScreenLevel("foo") == nil)
    }

    @Test
    func parseScreenLevel_valid() {
        #expect(parseScreenLevel("0") == .quiet)
        #expect(parseScreenLevel("1") == .medium)
        #expect(parseScreenLevel("2") == .verbose)
        #expect(parseScreenLevel("3") == .debug)
    }

    @Test
    func parseString_valid() {
        #expect(parseString("hello") == "hello")
        #expect(parseString("")?.isEmpty == true)
    }
}
