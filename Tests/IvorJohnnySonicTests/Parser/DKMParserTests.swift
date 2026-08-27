// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import IvorJohnnySonic
import Testing

struct DKMParserTests {
}

// MARK: -

extension DKMParserTests {
    @Test
    func parse_dynamicsSection_producesDynamicsCommand() throws {
        let score = try parseScore("/DYN\n")

        #expect(score.commands == [.dynamics])
    }

    @Test
    func parse_dynamicsSectionWithDataLine_throwsUnexpectedDataLine() throws {
        #expect(throws: DKMParser.Error.self) {
            try parseScore("/Dynamics\n0.0 1.0\n")
        }
    }

    @Test
    func parseAbbreviatedSectionName() throws {
        let score = try parseScore("/Tem\n0.0 1.0 60.0 60.0\n")

        #expect(score.commands == [.tempoLine(DKMTempoLine(startBeat: 0.0,
                                                           duration: 1.0,
                                                           initialTempo: 60.0,
                                                           finalTempo: 60.0))])
    }

    @Test
    func parseAllCommandsFixture_producesNoDiagnostics() throws {
        let data = try loadFixture("AllCommands", extension: "dkm")
        let (_, diagnostics) = try DKMParser().parse(data)

        #expect(diagnostics.isEmpty)
    }

    @Test
    func parseChorusLine() throws {
        let score = try parseScore("/Chorus\n1.0 2.0 4 0.5 0\n")

        #expect(score.commands == [.chorusLine(DKMChorusLine(startBeat: 1.0,
                                                             duration: 2.0,
                                                             numberOfVoices: 4,
                                                             depth: 0.5,
                                                             flipChannels: false))])
    }

    @Test
    func parseChorusLineWithFractionalNumberOfVoices_producesTruncatedIntegerParameterDiagnostic() throws {
        let (score, diagnostics) = try parseScoreWithDiagnostics("/Chorus\n1.0 2.0 4.0 0.5 0\n")

        #expect(score.commands == [.chorusLine(DKMChorusLine(startBeat: 1.0,
                                                             duration: 2.0,
                                                             numberOfVoices: 4,
                                                             depth: 0.5,
                                                             flipChannels: false))])
        #expect(diagnostics == [.truncatedIntegerParameter(lineNumber: 2, parameter: "numberOfVoices", value: 4.0)])
    }

    @Test
    func parseClipMode() throws {
        let score = try parseScore("/Clip\n1 ExtSound\n")

        #expect(score.commands == [.clipMode(DKMClipMode(channel: .right, name: "ExtSound"))])
    }

    @Test
    func parseClipModeWithNote() throws {
        let score = try parseScore("/Clip\n1 ExtSound\n5.1 2.2 5.0 0.5 0.1 1.1 ClipTest\n")
        let expected: [DKMCommand] = [.clipMode(DKMClipMode(channel: .right, name: "ExtSound")),
                                      .clipNote(DKMClipNote(startBeat: 5.1,
                                                            duration: 2.2,
                                                            volume: 5.0,
                                                            location: 0.5,
                                                            clipStart: 0.1,
                                                            clipRate: 1.1,
                                                            instrument: "ClipTest"))]

        #expect(score.commands == expected)
    }

    @Test
    func parseComment() throws {
        let score = try parseScore("! This is a comment\n")

        #expect(score.commands == [.comment(" This is a comment")])
    }

    @Test
    func parseCommentBetweenSameCommands() throws {
        let score = try parseScore("/Tempo\n0.0 1.0 57.0 57.0\n! interleaved\n137.0 9.0 57.0 69.0\n")
        let expected: [DKMCommand] = [.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0)),
                                      .comment(" interleaved"),
                                      .tempoLine(DKMTempoLine(startBeat: 137.0, duration: 9.0, initialTempo: 57.0, finalTempo: 69.0))]

        #expect(score.commands == expected)
    }

    @Test
    func parseCompressLine() throws {
        let score = try parseScore("/Compress\n5.0 10.0 8.0\n")

        #expect(score.commands == [.compressLine(DKMCompressLine(startBeat: 5.0, duration: 10.0, maxRatio: 8.0))])
    }

    @Test
    func parseDifferentSections() throws {
        let score = try parseScore("/Tempo\n0.0 1.0 60.0 60.0\n/Pulse\n10.0 B\n")
        let expected: [DKMCommand] = [.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0)),
                                      .pulseLine(DKMPulseLine(startBeat: 10.0, channel: .both))]

        #expect(score.commands == expected)
    }

    @Test
    func parseEmptyComment() throws {
        let score = try parseScore("!\n")

        #expect(score.commands == [.comment("")])
    }

    @Test
    func parseEmptyScore() throws {
        let (score, _) = try DKMParser().parse(Data())

        #expect(score.commands.isEmpty)
    }

    @Test
    func parseEnd() throws {
        let score = try parseScore("/End\n")

        #expect(score.commands == [.end])
    }

    @Test
    func parseExclude() throws {
        let score = try parseScore("/Exclude\n")

        #expect(score.commands == [.exclude])
    }

    @Test
    func parseFilterLine() throws {
        let score = try parseScore("/Filter\n8.0 20.0 5 -550.0 -550.0 -80.0 -80.0\n")

        #expect(score.commands == [.filterLine(DKMFilterLine(startBeat: 8.0,
                                                             duration: 20.0,
                                                             filterType: .butterworthBandpass,
                                                             initialPitch: -550.0,
                                                             finalPitch: -550.0,
                                                             initialBandwidth: -80.0,
                                                             finalBandwidth: -80.0))])
    }

    @Test
    func parseFlangeLine() throws {
        let score = try parseScore("/Flange\n2.0 5.0 2 0.8 1\n")

        #expect(score.commands == [.flangeLine(DKMFlangeLine(startBeat: 2.0,
                                                             duration: 5.0,
                                                             numberOfVoices: 2,
                                                             depth: 0.8,
                                                             flipChannels: true))])
    }

    @Test
    func parseFreqBandAnalyzeLine() throws {
        let score = try parseScore("/FBA\n1.0 2.0 0 S\n")

        #expect(score.commands == [.freqBandAnalyzeLine(DKMFreqBandAnalyzeLine(startBeat: 1.0,
                                                                               duration: 2.0,
                                                                               channel: .left,
                                                                               buffer: .sound))])
    }

    @Test
    func parseGEQLine() throws {
        let score = try parseScore("/GEQ\n15.0 3.0 2.0 0.0 -5.0\n")

        #expect(score.commands == [.geqLine(DKMGEQLine(beat: 15.0, bandGains: [3.0, 2.0, 0.0, -5.0]))])
    }

    @Test
    func parseGEQLineNoBandGains() throws {
        let score = try parseScore("/GEQ\n10.0\n")

        #expect(score.commands == [.geqLine(DKMGEQLine(beat: 10.0, bandGains: []))])
    }

    @Test
    func parseGEQLineWith29BandGains_producesBandGainCountMismatchDiagnostic() throws {
        let gains = Array(repeating: "0.0", count: 29).joined(separator: " ")
        let (score, diagnostics) = try parseScoreWithDiagnostics("/GEQ\n0.0 \(gains)\n")

        #expect(score.commands == [.geqLine(DKMGEQLine(beat: 0.0, bandGains: Array(repeating: 0.0, count: 29)))])
        #expect(diagnostics == [.bandGainCountMismatch(lineNumber: 2, count: 29)])
    }

    @Test
    func parseGEQLineWith31BandGains_producesBandGainCountMismatchDiagnostic() throws {
        let gains = Array(repeating: "0.0", count: 31).joined(separator: " ")
        let (score, diagnostics) = try parseScoreWithDiagnostics("/GEQ\n0.0 \(gains)\n")

        #expect(score.commands == [.geqLine(DKMGEQLine(beat: 0.0, bandGains: Array(repeating: 0.0, count: 31)))])
        #expect(diagnostics == [.bandGainCountMismatch(lineNumber: 2, count: 31)])
    }

    @Test
    func parseGEQLineWithExactly30BandGains_producesNoDiagnostic() throws {
        let gains = Array(repeating: "0.0", count: 30).joined(separator: " ")
        let (_, diagnostics) = try parseScoreWithDiagnostics("/GEQ\n0.0 \(gains)\n")

        #expect(diagnostics.isEmpty)
    }

    @Test
    func parseHaas() throws {
        let score = try parseScore("/Haas\n1 20.0 50.0 0\n")

        #expect(score.commands == [.haas(DKMHaas(enabled: true,
                                                 minDelay: 20.0,
                                                 maxDelay: 50.0,
                                                 reverbSend: false))])
    }

    @Test
    func parseIgnoresWhitespaceOnlyLines() throws {
        let score = try parseScore("  \n/End\n\t\n")

        #expect(score.commands == [.end])
    }

    @Test
    func parseInclude() throws {
        let score = try parseScore("/Include\nData/Ivor2\n")

        #expect(score.commands == [.include("Data/Ivor2")])
    }

    @Test
    func parseLevelsLine() throws {
        let score = try parseScore("/Levels\n5.0 10.0 -3.0 0.0\n")

        #expect(score.commands == [.levelsLine(DKMLevelsLine(startBeat: 5.0,
                                                             duration: 10.0,
                                                             startGainLossdB: -3.0,
                                                             endGainLossdB: 0.0))])
    }

    @Test
    func parseMixedScore() throws {
        let score = try parseScore("! Header\n/SFN\ntest.aiff\n/Tempo\n0.0 1.0 120.0 120.0\n/End\n")
        let expected: [DKMCommand] = [.comment(" Header"),
                                      .soundFileName("test.aiff"),
                                      .tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 120.0, finalTempo: 120.0)),
                                      .end]

        #expect(score.commands == expected)
    }

    @Test
    func parseMixLine() throws {
        let score = try parseScore("/Mix\n0.0 10.0 0.0 0 1.0 0.0\n")

        #expect(score.commands == [.mixLine(DKMMixLine(startBeat: 0.0,
                                                       duration: 10.0,
                                                       gainLossdB: 0.0,
                                                       keepSoundBuffer: false,
                                                       sign: 1.0,
                                                       timeOffset: 0.0))])
    }

    @Test
    func parseMultipleClipModes() throws {
        let score = try parseScore("/Clip\n1 FirstClip\n1.0 2.0 5.0 0.0 0.0 1.0 Inst\n/Clip\n0 SecondClip\n")
        let expected: [DKMCommand] = [.clipMode(DKMClipMode(channel: .right, name: "FirstClip")),
                                      .clipNote(DKMClipNote(startBeat: 1.0,
                                                            duration: 2.0,
                                                            volume: 5.0,
                                                            location: 0.0,
                                                            clipStart: 0.0,
                                                            clipRate: 1.0,
                                                            instrument: "Inst")),
                                      .clipMode(DKMClipMode(channel: .left, name: "SecondClip"))]

        #expect(score.commands == expected)
    }

    @Test
    func parseMultipleComments() throws {
        let score = try parseScore("! First\n! Second\n")

        #expect(score.commands == [.comment(" First"), .comment(" Second")])
    }

    @Test
    func parseMultipleTempoLines() throws {
        let score = try parseScore("/Tempo\n0.0 1.0 57.0 57.0\n137.0 9.0 57.0 69.0\n")
        let expected: [DKMCommand] = [.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0)),
                                      .tempoLine(DKMTempoLine(startBeat: 137.0, duration: 9.0, initialTempo: 57.0, finalTempo: 69.0))]

        #expect(score.commands == expected)
    }

    @Test
    func parsePitchesNote() throws {
        let score = try parseScore("/Pitches\n5.1 2.2 5.0 0.5 47.0 47.0 FiltNz0\n")

        #expect(score.commands == [.pitchesNote(DKMPitchesNote(startBeat: 5.1,
                                                               duration: 2.2,
                                                               volume: 5.0,
                                                               location: 0.5,
                                                               startPitch: 47.0,
                                                               endPitch: 47.0,
                                                               instrument: "FiltNz0"))])
    }

    @Test
    func parsePulseLine() throws {
        let score = try parseScore("/Pulse\n10.0 L\n")

        #expect(score.commands == [.pulseLine(DKMPulseLine(startBeat: 10.0, channel: .left))])
    }

    @Test
    func parsePulseLineRightChannel() throws {
        let score = try parseScore("/Pulse\n5.0 R\n")

        #expect(score.commands == [.pulseLine(DKMPulseLine(startBeat: 5.0, channel: .right))])
    }

    @Test
    func parseRejectsInvalidParameterCount() throws {
        #expect(throws: DKMParser.Error.self) {
            try parseScore("/Tempo\n0.0 1.0\n")
        }
    }

    @Test
    func parseRejectsInvalidParameterValue() throws {
        #expect(throws: DKMParser.Error.self) {
            try parseScore("/ScreenOut\nfoo\n")
        }
    }

    @Test
    func parseRejectsInvalidSection() throws {
        #expect(throws: DKMParser.Error.self) {
            try parseScore("/Unknown\n")
        }
    }

    @Test
    func parseRejectsInvalidUTF8Data() {
        #expect(throws: DKMParser.Error.self) {
            try DKMParser().parse(Data([0xff, 0xfe]))
        }
    }

    @Test
    func parseRejectsUnexpectedDataLine() throws {
        #expect(throws: DKMParser.Error.self) {
            try parseScore("0.0 1.0 57.0 57.0\n")
        }
    }

    @Test
    func parseReturnsValidData() throws {
        let (score, _) = try DKMParser().parse(Data("/End\n".utf8))

        #expect(score.commands == [.end])
    }

    @Test
    func parseReverbLine() throws {
        let score = try parseScore("/Reverb\n8.8 12.0 1 3 1.2 0.8 0.2 0.6\n")

        #expect(score.commands == [.reverbLine(DKMReverbLine(startBeat: 8.8,
                                                             duration: 12.0,
                                                             direction: .forward,
                                                             size: .large,
                                                             reverbTime: 1.2,
                                                             combFilterDryGain: 0.8,
                                                             xTalkFactor: 0.2,
                                                             wetness: 0.6))])
    }

    @Test
    func parseScreenOut() throws {
        let score = try parseScore("/ScreenOut\n2\n")

        #expect(score.commands == [.screenOut(.verbose)])
    }

    @Test
    func parseSendBackLine() throws {
        let score = try parseScore("/SendBack\n5.0 10.0 -6.0\n")

        #expect(score.commands == [.sendBackLine(DKMSendBackLine(startBeat: 5.0, duration: 10.0, gainLossdB: -6.0))])
    }

    @Test
    func parseShowBufferLine() throws {
        let score = try parseScore("/ShowBuffer\n1.0 2.0\n")

        #expect(score.commands == [.showBufferLine(DKMShowBufferLine(startBeat: 1.0, duration: 2.0))])
    }

    @Test
    func parseSoundFileName() throws {
        let score = try parseScore("/SFN\nout.aiff\n")

        #expect(score.commands == [.soundFileName("out.aiff")])
    }

    @Test
    func parseStatsLine() throws {
        let score = try parseScore("/Stats\n0.0 5.0\n")

        #expect(score.commands == [.statsLine(DKMStatsLine(startBeat: 0.0, duration: 5.0))])
    }

    @Test
    func parseTempoLine() throws {
        let score = try parseScore("/Tempo\n0.0 1.0 57.0 57.0\n")

        #expect(score.commands == [.tempoLine(DKMTempoLine(startBeat: 0.0,
                                                           duration: 1.0,
                                                           initialTempo: 57.0,
                                                           finalTempo: 57.0))])
    }

    @Test
    func parseTuning() throws {
        let score = try parseScore("/Tuning\n1.0 19.0 3.0 1.021974864\n")

        #expect(score.commands == [.tuning(DKMTuning(primaryInterval: 1.0,
                                                     notesPerInterval: 19.0,
                                                     pitchConvExponent: 3.0,
                                                     pitchConvFactor: 1.021974864))])
    }

    @Test
    func parseVocodeMode() throws {
        let score = try parseScore("/Vocode\n1 ExtSound 1.0 0 2.2 4.0 1.1 0 3.0\n")

        #expect(score.commands == [.vocodeMode(DKMVocodeMode(channel: .right,
                                                             name: "ExtSound",
                                                             clipRate: 1.0,
                                                             maxHarm: 0,
                                                             slope: 2.2,
                                                             bassBoost: 4.0,
                                                             dynExponent: 1.1,
                                                             shiftN: 0,
                                                             peakReduction: 3.0))])
    }

    @Test
    func parseVocodeNote() throws {
        let score = try parseScore("/Vocode\n1 ExtSound 1.0 0 0.0 0.0 1.0 0 0.0\n5.1 2.2 5.0 -0.5 -120.0 1.1 VanON\n")
        let expected: [DKMCommand] = [.vocodeMode(DKMVocodeMode(channel: .right,
                                                                name: "ExtSound",
                                                                clipRate: 1.0,
                                                                maxHarm: 0,
                                                                slope: 0.0,
                                                                bassBoost: 0.0,
                                                                dynExponent: 1.0,
                                                                shiftN: 0,
                                                                peakReduction: 0.0)),
                                      .vocodeNote(DKMVocodeNote(startBeat: 5.1,
                                                                duration: 2.2,
                                                                volume: 5.0,
                                                                location: -0.5,
                                                                pitch: -120.0,
                                                                clipStart: 1.1,
                                                                instrument: "VanON"))]

        #expect(score.commands == expected)
    }
}
