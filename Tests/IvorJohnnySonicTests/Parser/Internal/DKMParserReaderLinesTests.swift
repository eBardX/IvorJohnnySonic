// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMParserReaderLinesTests {
}

// MARK: -

extension DKMParserReaderLinesTests {
    @Test
    func parseChorusLine() throws {
        var reader = DKMParser.Reader(lines: [])

        let command = try reader.parseChorusLine("0.0 4.0 4 0.5 0")

        guard case let .chorusLine(line) = command
        else { Issue.record("Expected .chorusLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.numberOfVoices == 4)
        #expect(line.depth == 0.5)
        #expect(!line.flipChannels)
    }

    @Test
    func parseClipMode() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseClipMode("0 Drums")

        guard case let .clipMode(mode) = command
        else { Issue.record("Expected .clipMode command"); return }

        #expect(mode.channel == .left)
        #expect(mode.name == "Drums")
    }

    @Test
    func parseClipNote() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseClipNote("0.0 1.0 1.0 0.0 0.0 1.0 Drums")

        guard case let .clipNote(note) = command
        else { Issue.record("Expected .clipNote command"); return }

        #expect(note.startBeat == 0.0)
        #expect(note.duration == 1.0)
        #expect(note.volume == 1.0)
        #expect(note.location == 0.0)
        #expect(note.clipStart == 0.0)
        #expect(note.clipRate == 1.0)
        #expect(note.instrument == "Drums")
    }

    @Test
    func parseCompressLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseCompressLine("0.0 4.0 6.0")

        guard case let .compressLine(line) = command
        else { Issue.record("Expected .compressLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.maxRatio == 6.0)
    }

    @Test
    func parseFBALine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseFBALine("0.0 4.0 -1 S")

        guard case let .freqBandAnalyzeLine(line) = command
        else { Issue.record("Expected .freqBandAnalyzeLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.channel == .combined)
        #expect(line.buffer == .sound)
    }

    @Test
    func parseFilterLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseFilterLine("0.0 4.0 3 60.0 60.0 2.0 2.0")

        guard case let .filterLine(line) = command
        else { Issue.record("Expected .filterLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.filterType == .butterworthLowpass)
        #expect(line.initialPitch == 60.0)
        #expect(line.finalPitch == 60.0)
        #expect(line.initialBandwidth == 2.0)
        #expect(line.finalBandwidth == 2.0)
    }

    @Test
    func parseFlangeLine() throws {
        var reader = DKMParser.Reader(lines: [])

        let command = try reader.parseFlangeLine("0.0 4.0 4 0.5 1")

        guard case let .flangeLine(line) = command
        else { Issue.record("Expected .flangeLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.numberOfVoices == 4)
        #expect(line.depth == 0.5)
        #expect(line.flipChannels)
    }

    @Test
    func parseGEQLine() throws {
        var reader = DKMParser.Reader(lines: [])

        let command = try reader.parseGEQLine("0.0 1.0 2.0 3.0")

        guard case let .geqLine(line) = command
        else { Issue.record("Expected .geqLine command"); return }

        #expect(line.beat == 0.0)
        #expect(line.bandGains == [1.0, 2.0, 3.0])
    }

    @Test
    func parseHaas() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseHaas("1 10.0 40.0 0")

        guard case let .haas(haas) = command
        else { Issue.record("Expected .haas command"); return }

        #expect(haas.enabled)
        #expect(haas.minDelay == 10.0)
        #expect(haas.maxDelay == 40.0)
        #expect(!haas.reverbSend)
    }

    @Test
    func parseLevelsLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseLevelsLine("0.0 4.0 -6.0 0.0")

        guard case let .levelsLine(line) = command
        else { Issue.record("Expected .levelsLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.startGainLossdB == -6.0)
        #expect(line.endGainLossdB == 0.0)
    }

    @Test
    func parseMixLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseMixLine("0.0 4.0 0.0 1 1.0 0.0")

        guard case let .mixLine(line) = command
        else { Issue.record("Expected .mixLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.gainLossdB == 0.0)
        #expect(line.keepSoundBuffer)
        #expect(line.sign == 1.0)
        #expect(line.timeOffset == 0.0)
    }

    @Test
    func parsePitchesNote() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parsePitchesNote("0.0 1.0 1.0 0.0 60.0 60.0 Piano")

        guard case let .pitchesNote(note) = command
        else { Issue.record("Expected .pitchesNote command"); return }

        #expect(note.startBeat == 0.0)
        #expect(note.duration == 1.0)
        #expect(note.volume == 1.0)
        #expect(note.location == 0.0)
        #expect(note.startPitch == 60.0)
        #expect(note.endPitch == 60.0)
        #expect(note.instrument == "Piano")
    }

    @Test
    func parsePulseLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parsePulseLine("0.0 B")

        guard case let .pulseLine(line) = command
        else { Issue.record("Expected .pulseLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.channel == .both)
    }

    @Test
    func parseReverbLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseReverbLine("0.0 4.0 1 2 1.5 0.5 0.3 0.4")

        guard case let .reverbLine(line) = command
        else { Issue.record("Expected .reverbLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.direction == .forward)
        #expect(line.size == .medium)
        #expect(line.reverbTime == 1.5)
        #expect(line.combFilterDryGain == 0.5)
        #expect(line.xTalkFactor == 0.3)
        #expect(line.wetness == 0.4)
    }

    @Test
    func parseScreenOut() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseScreenOut("2")

        guard case let .screenOut(level) = command
        else { Issue.record("Expected .screenOut command"); return }

        #expect(level == .verbose)
    }

    @Test
    func parseSendBackLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseSendBackLine("0.0 4.0 -3.0")

        guard case let .sendBackLine(line) = command
        else { Issue.record("Expected .sendBackLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.gainLossdB == -3.0)
    }

    @Test
    func parseShowBufferLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseShowBufferLine("0.0 4.0")

        guard case let .showBufferLine(line) = command
        else { Issue.record("Expected .showBufferLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
    }

    @Test
    func parseStatsLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseStatsLine("0.0 4.0")

        guard case let .statsLine(line) = command
        else { Issue.record("Expected .statsLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
    }

    @Test
    func parseTempoLine() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseTempoLine("0.0 4.0 60.0 120.0")

        guard case let .tempoLine(line) = command
        else { Issue.record("Expected .tempoLine command"); return }

        #expect(line.startBeat == 0.0)
        #expect(line.duration == 4.0)
        #expect(line.initialTempo == 60.0)
        #expect(line.finalTempo == 120.0)
    }

    @Test
    func parseTuning() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseTuning("2.0 12.0 3.0 1.021974864")

        guard case let .tuning(tuning) = command
        else { Issue.record("Expected .tuning command"); return }

        #expect(tuning.primaryInterval == 2.0)
        #expect(tuning.notesPerInterval == 12.0)
        #expect(tuning.pitchConvExponent == 3.0)
        #expect(tuning.pitchConvFactor == 1.021974864)
    }

    @Test
    func parseVocodeMode() throws {
        var reader = DKMParser.Reader(lines: [])

        let command = try reader.parseVocodeMode("0 Voice 1.0 0 0.0 0.0 1.0 0 0.0")

        guard case let .vocodeMode(mode) = command
        else { Issue.record("Expected .vocodeMode command"); return }

        #expect(mode.channel == .left)
        #expect(mode.name == "Voice")
        #expect(mode.clipRate == 1.0)
        #expect(mode.maxHarm == 0)
        #expect(mode.slope == 0.0)
        #expect(mode.bassBoost == 0.0)
        #expect(mode.dynExponent == 1.0)
        #expect(mode.shiftN == 0)
        #expect(mode.peakReduction == 0.0)
    }

    @Test
    func parseVocodeNote() throws {
        let reader = DKMParser.Reader(lines: [])

        let command = try reader.parseVocodeNote("0.0 1.0 1.0 0.0 60.0 0.0 Voice")

        guard case let .vocodeNote(note) = command
        else { Issue.record("Expected .vocodeNote command"); return }

        #expect(note.startBeat == 0.0)
        #expect(note.duration == 1.0)
        #expect(note.volume == 1.0)
        #expect(note.location == 0.0)
        #expect(note.pitch == 60.0)
        #expect(note.clipStart == 0.0)
        #expect(note.instrument == "Voice")
    }
}
