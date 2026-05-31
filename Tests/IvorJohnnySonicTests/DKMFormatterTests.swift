// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import IvorJohnnySonic
import Testing

struct DKMFormatterTests {
}

// MARK: -

extension DKMFormatterTests {
    @Test
    func formatChorusLine() throws {
        let score = DKMScore(commands: [.chorusLine(startBeat: 1.0,
                                                    duration: 2.0,
                                                    numberOfVoices: 4,
                                                    depth: 0.5,
                                                    flipChannels: false)])
        let result = try formatScore(score)

        #expect(result == "/Chorus\n1.0 2.0 4 0.5 0\n")
    }

    @Test
    func formatClipMode() throws {
        let score = DKMScore(commands: [.clipMode(channel: .right, name: "ExtSound")])
        let result = try formatScore(score)

        #expect(result == "/Clip\n1 ExtSound\n")
    }

    @Test
    func formatClipModeWithNote() throws {
        let score = DKMScore(commands: [.clipMode(channel: .right, name: "ExtSound"),
                                        .clipNote(startBeat: 5.1,
                                                  duration: 2.2,
                                                  volume: 5.0,
                                                  location: 0.5,
                                                  clipStart: 0.1,
                                                  clipRate: 1.1,
                                                  instrument: "ClipTest")])
        let result = try formatScore(score)

        #expect(result == "/Clip\n1 ExtSound\n5.1 2.2 5.0 0.5 0.1 1.1 ClipTest\n")
    }

    @Test
    func formatComment() throws {
        let score = DKMScore(commands: [.comment(" This is a comment")])
        let result = try formatScore(score)

        #expect(result == "! This is a comment\n")
    }

    @Test
    func formatCommentBetweenSameCommands() throws {
        let score = DKMScore(commands: [.tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0),
                                        .comment(" interleaved"),
                                        .tempoLine(startBeat: 137.0, duration: 9.0, initialTempo: 57.0, finalTempo: 69.0)])
        let result = try formatScore(score)

        #expect(result == "/Tempo\n0.0 1.0 57.0 57.0\n! interleaved\n137.0 9.0 57.0 69.0\n")
    }

    @Test
    func formatCompressLine() throws {
        let score = DKMScore(commands: [.compressLine(startBeat: 5.0, duration: 10.0, maxRatio: 8.0)])
        let result = try formatScore(score)

        #expect(result == "/Compress\n5.0 10.0 8.0\n")
    }

    @Test
    func formatDifferentSections() throws {
        let score = DKMScore(commands: [.tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 60.0, finalTempo: 60.0),
                                        .pulseLine(startBeat: 10.0, channel: .both)])
        let result = try formatScore(score)

        #expect(result == "/Tempo\n0.0 1.0 60.0 60.0\n/Pulse\n10.0 B\n")
    }

    @Test
    func formatEmptyComment() throws {
        let score = DKMScore(commands: [.comment("")])
        let result = try formatScore(score)

        #expect(result == "!\n")
    }

    @Test
    func formatEmptyScore() throws {
        let score = DKMScore(commands: [])
        let data = try DKMFormatter().format(score)

        #expect(data.isEmpty)
    }

    @Test
    func formatEnd() throws {
        let score = DKMScore(commands: [.end])
        let result = try formatScore(score)

        #expect(result == "/End\n")
    }

    @Test
    func formatExclude() throws {
        let score = DKMScore(commands: [.exclude])
        let result = try formatScore(score)

        #expect(result == "/Exclude\n")
    }

    @Test
    func formatFilterLine() throws {
        let score = DKMScore(commands: [.filterLine(startBeat: 8.0,
                                                    duration: 20.0,
                                                    filterType: .butterworthBandpass,
                                                    initialPitch: -550.0,
                                                    finalPitch: -550.0,
                                                    initialBandwidth: -80.0,
                                                    finalBandwidth: -80.0)])
        let result = try formatScore(score)

        #expect(result == "/Filter\n8.0 20.0 5 -550.0 -550.0 -80.0 -80.0\n")
    }

    @Test
    func formatFlangeLine() throws {
        let score = DKMScore(commands: [.flangeLine(startBeat: 2.0,
                                                    duration: 5.0,
                                                    numberOfVoices: 2,
                                                    depth: 0.8,
                                                    flipChannels: true)])
        let result = try formatScore(score)

        #expect(result == "/Flange\n2.0 5.0 2 0.8 1\n")
    }

    @Test
    func formatFreqBandAnalyzeLine() throws {
        let score = DKMScore(commands: [.freqBandAnalyzeLine(startBeat: 1.0,
                                                             duration: 2.0,
                                                             channel: .left,
                                                             buffer: .sound)])
        let result = try formatScore(score)

        #expect(result == "/FBA\n1.0 2.0 0 S\n")
    }

    @Test
    func formatGEQLine() throws {
        let score = DKMScore(commands: [.geqLine(beat: 15.0, bandGains: [3.0, 2.0, 0.0, -5.0])])
        let result = try formatScore(score)

        #expect(result == "/GEQ\n15.0 3.0 2.0 0.0 -5.0\n")
    }

    @Test
    func formatGEQLineNoBandGains() throws {
        let score = DKMScore(commands: [.geqLine(beat: 10.0, bandGains: [])])
        let result = try formatScore(score)

        #expect(result == "/GEQ\n10.0\n")
    }

    @Test
    func formatHaas() throws {
        let score = DKMScore(commands: [.haas(enabled: true,
                                              minDelay: 20.0,
                                              maxDelay: 50.0,
                                              reverbSend: false)])
        let result = try formatScore(score)

        #expect(result == "/Haas\n1 20.0 50.0 0\n")
    }

    @Test
    func formatInclude() throws {
        let score = DKMScore(commands: [.include("Data/Ivor2")])
        let result = try formatScore(score)

        #expect(result == "/Include\nData/Ivor2\n")
    }

    @Test
    func formatLevelsLine() throws {
        let score = DKMScore(commands: [.levelsLine(startBeat: 5.0,
                                                    duration: 10.0,
                                                    startGainLossdB: -3.0,
                                                    endGainLossdB: 0.0)])
        let result = try formatScore(score)

        #expect(result == "/Levels\n5.0 10.0 -3.0 0.0\n")
    }

    @Test
    func formatMixLine() throws {
        let score = DKMScore(commands: [.mixLine(startBeat: 0.0,
                                                 duration: 10.0,
                                                 gainLossdB: 0.0,
                                                 keepSoundBuffer: false,
                                                 sign: 1.0,
                                                 timeOffset: 0.0)])
        let result = try formatScore(score)

        #expect(result == "/Mix\n0.0 10.0 0.0 0 1.0 0.0\n")
    }

    @Test
    func formatMixedScore() throws {
        let score = DKMScore(commands: [.comment(" Header"),
                                        .soundFileName("test.aiff"),
                                        .tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 120.0, finalTempo: 120.0),
                                        .end])
        let result = try formatScore(score)

        #expect(result == "! Header\n/SFN\ntest.aiff\n/Tempo\n0.0 1.0 120.0 120.0\n/End\n")
    }

    @Test
    func formatMultipleClipModes() throws {
        let score = DKMScore(commands: [.clipMode(channel: .right, name: "FirstClip"),
                                        .clipNote(startBeat: 1.0,
                                                  duration: 2.0,
                                                  volume: 5.0,
                                                  location: 0.0,
                                                  clipStart: 0.0,
                                                  clipRate: 1.0,
                                                  instrument: "Inst"),
                                        .clipMode(channel: .left, name: "SecondClip")])
        let result = try formatScore(score)

        #expect(result == "/Clip\n1 FirstClip\n1.0 2.0 5.0 0.0 0.0 1.0 Inst\n/Clip\n0 SecondClip\n")
    }

    @Test
    func formatMultipleComments() throws {
        let score = DKMScore(commands: [.comment(" First"),
                                        .comment(" Second")])
        let result = try formatScore(score)

        #expect(result == "! First\n! Second\n")
    }

    @Test
    func formatMultipleTempoLines() throws {
        let score = DKMScore(commands: [.tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0),
                                        .tempoLine(startBeat: 137.0, duration: 9.0, initialTempo: 57.0, finalTempo: 69.0)])
        let result = try formatScore(score)

        #expect(result == "/Tempo\n0.0 1.0 57.0 57.0\n137.0 9.0 57.0 69.0\n")
    }

    @Test
    func formatPitchesNote() throws {
        let score = DKMScore(commands: [.pitchesNote(startBeat: 5.1,
                                                     duration: 2.2,
                                                     volume: 5.0,
                                                     location: 0.5,
                                                     startPitch: 47.0,
                                                     endPitch: 47.0,
                                                     instrument: "FiltNz0")])
        let result = try formatScore(score)

        #expect(result == "/Pitches\n5.1 2.2 5.0 0.5 47.0 47.0 FiltNz0\n")
    }

    @Test
    func formatPulseLine() throws {
        let score = DKMScore(commands: [.pulseLine(startBeat: 10.0, channel: .left)])
        let result = try formatScore(score)

        #expect(result == "/Pulse\n10.0 L\n")
    }

    @Test
    func formatPulseLineRightChannel() throws {
        let score = DKMScore(commands: [.pulseLine(startBeat: 5.0, channel: .right)])
        let result = try formatScore(score)

        #expect(result == "/Pulse\n5.0 R\n")
    }

    @Test
    func formatRejectsStringWithNewline() throws {
        let score = DKMScore(commands: [.soundFileName("bad\nvalue")])

        #expect(throws: DKMFormatError.self) {
            try DKMFormatter().format(score)
        }
    }

    @Test
    func formatReturnsValidUTF8Data() throws {
        let score = DKMScore(commands: [.end])
        let data = try DKMFormatter().format(score)
        let result = String(data: data, encoding: .utf8)

        #expect(result != nil)
    }

    @Test
    func formatReverbLine() throws {
        let score = DKMScore(commands: [.reverbLine(startBeat: 8.8,
                                                    duration: 12.0,
                                                    direction: .forward,
                                                    size: .large,
                                                    reverbTime: 1.2,
                                                    combFilterDryGain: 0.8,
                                                    xTalkFactor: 0.2,
                                                    wetness: 0.6)])
        let result = try formatScore(score)

        #expect(result == "/Reverb\n8.8 12.0 1 3 1.2 0.8 0.2 0.6\n")
    }

    @Test
    func formatScreenOut() throws {
        let score = DKMScore(commands: [.screenOut(.verbose)])
        let result = try formatScore(score)

        #expect(result == "/ScreenOut\n2\n")
    }

    @Test
    func formatSendBackLine() throws {
        let score = DKMScore(commands: [.sendBackLine(startBeat: 5.0, duration: 10.0, gainLossdB: -6.0)])
        let result = try formatScore(score)

        #expect(result == "/SendBack\n5.0 10.0 -6.0\n")
    }

    @Test
    func formatShowBufferLine() throws {
        let score = DKMScore(commands: [.showBufferLine(startBeat: 1.0, duration: 2.0)])
        let result = try formatScore(score)

        #expect(result == "/ShowBuffer\n1.0 2.0\n")
    }

    @Test
    func formatSoundFileName() throws {
        let score = DKMScore(commands: [.soundFileName("out.aiff")])
        let result = try formatScore(score)

        #expect(result == "/SFN\nout.aiff\n")
    }

    @Test
    func formatStatsLine() throws {
        let score = DKMScore(commands: [.statsLine(startBeat: 0.0, duration: 5.0)])
        let result = try formatScore(score)

        #expect(result == "/Stats\n0.0 5.0\n")
    }

    @Test
    func formatTempoLine() throws {
        let score = DKMScore(commands: [.tempoLine(startBeat: 0.0,
                                                   duration: 1.0,
                                                   initialTempo: 57.0,
                                                   finalTempo: 57.0)])
        let result = try formatScore(score)

        #expect(result == "/Tempo\n0.0 1.0 57.0 57.0\n")
    }

    @Test
    func formatTuning() throws {
        let score = DKMScore(commands: [.tuning(primaryInterval: 1.0,
                                                notesPerInterval: 19.0,
                                                pitchConvExponent: 3.0,
                                                pitchConvFactor: 1.021974864)])
        let result = try formatScore(score)

        #expect(result == "/Tuning\n1.0 19.0 3.0 1.021974864\n")
    }

    @Test
    func formatVocodeMode() throws {
        let score = DKMScore(commands: [.vocodeMode(channel: .right,
                                                    name: "ExtSound",
                                                    clipRate: 1.0,
                                                    maxHarm: 0,
                                                    slope: 2.2,
                                                    bassBoost: 4.0,
                                                    dynExponent: 1.1,
                                                    shiftN: 0,
                                                    peakReduction: 3.0)])
        let result = try formatScore(score)

        #expect(result == "/Vocode\n1 ExtSound 1.0 0 2.2 4.0 1.1 0 3.0\n")
    }

    @Test
    func formatVocodeNote() throws {
        let score = DKMScore(commands: [.vocodeMode(channel: .right,
                                                    name: "ExtSound",
                                                    clipRate: 1.0,
                                                    maxHarm: 0,
                                                    slope: 0.0,
                                                    bassBoost: 0.0,
                                                    dynExponent: 1.0,
                                                    shiftN: 0,
                                                    peakReduction: 0.0),
                                        .vocodeNote(startBeat: 5.1,
                                                    duration: 2.2,
                                                    volume: 5.0,
                                                    location: -0.5,
                                                    pitch: -120.0,
                                                    clipStart: 1.1,
                                                    instrument: "VanON")])
        let result = try formatScore(score)

        #expect(result == "/Vocode\n1 ExtSound 1.0 0 0.0 0.0 1.0 0 0.0\n5.1 2.2 5.0 -0.5 -120.0 1.1 VanON\n")
    }
}
