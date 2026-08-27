// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMCommandTests {
}

// MARK: -

extension DKMCommandTests {
    @Test
    func chorusLine() {
        let command = DKMCommand.chorusLine(DKMChorusLine(startBeat: 8.0,
                                                          duration: 12.5,
                                                          numberOfVoices: 4,
                                                          depth: 0.9,
                                                          flipChannels: false))

        if case let .chorusLine(line) = command {
            #expect(line.startBeat == 8.0)
            #expect(line.duration == 12.5)
            #expect(line.numberOfVoices == 4)
            #expect(line.depth == 0.9)
            #expect(line.flipChannels == false)
        } else {
            Issue.record("Expected .chorusLine case")
        }
    }

    @Test
    func clipMode() {
        let command = DKMCommand.clipMode(DKMClipMode(channel: .right, name: "ExtSound"))

        if case let .clipMode(mode) = command {
            #expect(mode.channel == .right)
            #expect(mode.name == "ExtSound")
        } else {
            Issue.record("Expected .clipMode case")
        }
    }

    @Test
    func clipNote() {
        let command = DKMCommand.clipNote(DKMClipNote(startBeat: 5.1,
                                                      duration: 2.2,
                                                      volume: 5.0,
                                                      location: 0.5,
                                                      clipStart: 0.1,
                                                      clipRate: 1.1,
                                                      instrument: "ClipTest"))

        if case let .clipNote(note) = command {
            #expect(note.startBeat == 5.1)
            #expect(note.duration == 2.2)
            #expect(note.volume == 5.0)
            #expect(note.location == 0.5)
            #expect(note.clipStart == 0.1)
            #expect(note.clipRate == 1.1)
            #expect(note.instrument == "ClipTest")
        } else {
            Issue.record("Expected .clipNote case")
        }
    }

    @Test
    func comment() {
        let command = DKMCommand.comment(" Hello")

        if case let .comment(text) = command {
            #expect(text == " Hello")
        } else {
            Issue.record("Expected .comment case")
        }
    }

    @Test
    func compressLine() {
        let command = DKMCommand.compressLine(DKMCompressLine(startBeat: 5.0, duration: 10.0, maxRatio: 8.0))

        if case let .compressLine(line) = command {
            #expect(line.startBeat == 5.0)
            #expect(line.duration == 10.0)
            #expect(line.maxRatio == 8.0)
        } else {
            Issue.record("Expected .compressLine case")
        }
    }

    @Test
    func end() {
        let command = DKMCommand.end

        if case .end = command {
            // pass
        } else {
            Issue.record("Expected .end case")
        }
    }

    @Test
    func equality() {
        #expect(DKMCommand.end == .end)
        #expect(DKMCommand.comment(" Hello") == .comment(" Hello"))
        #expect(DKMCommand.tempoLine(DKMTempoLine(startBeat: 0.0,
                                                  duration: 1.0,
                                                  initialTempo: 60.0,
                                                  finalTempo: 60.0)) == .tempoLine(DKMTempoLine(startBeat: 0.0,
                                                                                                duration: 1.0,
                                                                                                initialTempo: 60.0,
                                                                                                finalTempo: 60.0)))
    }

    @Test
    func exclude() {
        let command = DKMCommand.exclude

        if case .exclude = command {
            // pass
        } else {
            Issue.record("Expected .exclude case")
        }
    }

    @Test
    func filterLine() {
        let command = DKMCommand.filterLine(DKMFilterLine(startBeat: 8.0,
                                                          duration: 20.0,
                                                          filterType: .butterworthBandpass,
                                                          initialPitch: -550.0,
                                                          finalPitch: -550.0,
                                                          initialBandwidth: -80.0,
                                                          finalBandwidth: -80.0))

        if case let .filterLine(line) = command {
            #expect(line.startBeat == 8.0)
            #expect(line.duration == 20.0)
            #expect(line.filterType == .butterworthBandpass)
            #expect(line.initialPitch == -550.0)
            #expect(line.finalPitch == -550.0)
            #expect(line.initialBandwidth == -80.0)
            #expect(line.finalBandwidth == -80.0)
        } else {
            Issue.record("Expected .filterLine case")
        }
    }

    @Test
    func flangeLine() {
        let command = DKMCommand.flangeLine(DKMFlangeLine(startBeat: 2.0,
                                                          duration: 5.0,
                                                          numberOfVoices: 2,
                                                          depth: 0.8,
                                                          flipChannels: true))

        if case let .flangeLine(line) = command {
            #expect(line.startBeat == 2.0)
            #expect(line.duration == 5.0)
            #expect(line.numberOfVoices == 2)
            #expect(line.depth == 0.8)
            #expect(line.flipChannels == true)
        } else {
            Issue.record("Expected .flangeLine case")
        }
    }

    @Test
    func freqBandAnalyzeLine() {
        let command = DKMCommand.freqBandAnalyzeLine(DKMFreqBandAnalyzeLine(startBeat: 1.0,
                                                                            duration: 2.0,
                                                                            channel: .combined,
                                                                            buffer: .mix))

        if case let .freqBandAnalyzeLine(line) = command {
            #expect(line.startBeat == 1.0)
            #expect(line.duration == 2.0)
            #expect(line.channel == .combined)
            #expect(line.buffer == .mix)
        } else {
            Issue.record("Expected .freqBandAnalyzeLine case")
        }
    }

    @Test
    func geqLine() {
        let command = DKMCommand.geqLine(DKMGEQLine(beat: 15.0, bandGains: [3.0, 2.0, 0.0, -5.0]))

        if case let .geqLine(line) = command {
            #expect(line.beat == 15.0)
            #expect(line.bandGains == [3.0, 2.0, 0.0, -5.0])
        } else {
            Issue.record("Expected .geqLine case")
        }
    }

    @Test
    func haas() {
        let command = DKMCommand.haas(DKMHaas(enabled: true, minDelay: 20.0, maxDelay: 50.0, reverbSend: false))

        if case let .haas(haas) = command {
            #expect(haas.enabled == true)
            #expect(haas.minDelay == 20.0)
            #expect(haas.maxDelay == 50.0)
            #expect(haas.reverbSend == false)
        } else {
            Issue.record("Expected .haas case")
        }
    }

    @Test
    func include() {
        let command = DKMCommand.include("Data/Ivor2")

        if case let .include(fileName) = command {
            #expect(fileName == "Data/Ivor2")
        } else {
            Issue.record("Expected .include case")
        }
    }

    @Test
    func inequality() {
        #expect(DKMCommand.end != .exclude)
        #expect(DKMCommand.comment(" Hello") != .comment(" World"))
        #expect(DKMCommand.end != .comment(""))
    }

    @Test
    func levelsLine() {
        let command = DKMCommand.levelsLine(DKMLevelsLine(startBeat: 5.0,
                                                          duration: 10.0,
                                                          startGainLossdB: -3.0,
                                                          endGainLossdB: 0.0))

        if case let .levelsLine(line) = command {
            #expect(line.startBeat == 5.0)
            #expect(line.duration == 10.0)
            #expect(line.startGainLossdB == -3.0)
            #expect(line.endGainLossdB == 0.0)
        } else {
            Issue.record("Expected .levelsLine case")
        }
    }

    @Test
    func mixLine() {
        let command = DKMCommand.mixLine(DKMMixLine(startBeat: 0.0,
                                                    duration: 10.0,
                                                    gainLossdB: 0.0,
                                                    keepSoundBuffer: false,
                                                    sign: 1.0,
                                                    timeOffset: 0.0))

        if case let .mixLine(line) = command {
            #expect(line.startBeat == 0.0)
            #expect(line.duration == 10.0)
            #expect(line.gainLossdB == 0.0)
            #expect(line.keepSoundBuffer == false)
            #expect(line.sign == 1.0)
            #expect(line.timeOffset == 0.0)
        } else {
            Issue.record("Expected .mixLine case")
        }
    }

    @Test
    func pitchesNote() {
        let command = DKMCommand.pitchesNote(DKMPitchesNote(startBeat: 5.1,
                                                            duration: 2.2,
                                                            volume: 5.0,
                                                            location: 0.5,
                                                            startPitch: 47.0,
                                                            endPitch: 47.0,
                                                            instrument: "FiltNz0"))

        if case let .pitchesNote(note) = command {
            #expect(note.startBeat == 5.1)
            #expect(note.duration == 2.2)
            #expect(note.volume == 5.0)
            #expect(note.location == 0.5)
            #expect(note.startPitch == 47.0)
            #expect(note.endPitch == 47.0)
            #expect(note.instrument == "FiltNz0")
        } else {
            Issue.record("Expected .pitchesNote case")
        }
    }

    @Test
    func pulseLine() {
        let command = DKMCommand.pulseLine(DKMPulseLine(startBeat: 10.0, channel: .left))

        if case let .pulseLine(line) = command {
            #expect(line.startBeat == 10.0)
            #expect(line.channel == .left)
        } else {
            Issue.record("Expected .pulseLine case")
        }
    }

    @Test
    func reverbLine() {
        let command = DKMCommand.reverbLine(DKMReverbLine(startBeat: 8.8,
                                                          duration: 12.0,
                                                          direction: .forward,
                                                          size: .large,
                                                          reverbTime: 1.2,
                                                          combFilterDryGain: 0.8,
                                                          xTalkFactor: 0.2,
                                                          wetness: 0.6))

        if case let .reverbLine(line) = command {
            #expect(line.startBeat == 8.8)
            #expect(line.duration == 12.0)
            #expect(line.direction == .forward)
            #expect(line.size == .large)
            #expect(line.reverbTime == 1.2)
            #expect(line.combFilterDryGain == 0.8)
            #expect(line.xTalkFactor == 0.2)
            #expect(line.wetness == 0.6)
        } else {
            Issue.record("Expected .reverbLine case")
        }
    }

    @Test
    func screenOut() {
        let command = DKMCommand.screenOut(.verbose)

        if case let .screenOut(level) = command {
            #expect(level == .verbose)
        } else {
            Issue.record("Expected .screenOut case")
        }
    }

    @Test
    func sendBackLine() {
        let command = DKMCommand.sendBackLine(DKMSendBackLine(startBeat: 5.0, duration: 10.0, gainLossdB: -6.0))

        if case let .sendBackLine(line) = command {
            #expect(line.startBeat == 5.0)
            #expect(line.duration == 10.0)
            #expect(line.gainLossdB == -6.0)
        } else {
            Issue.record("Expected .sendBackLine case")
        }
    }

    @Test
    func showBufferLine() {
        let command = DKMCommand.showBufferLine(DKMShowBufferLine(startBeat: 1.0, duration: 2.0))

        if case let .showBufferLine(line) = command {
            #expect(line.startBeat == 1.0)
            #expect(line.duration == 2.0)
        } else {
            Issue.record("Expected .showBufferLine case")
        }
    }

    @Test
    func soundFileName() {
        let command = DKMCommand.soundFileName("Data/MyMasterpiece.AIFF")

        if case let .soundFileName(name) = command {
            #expect(name == "Data/MyMasterpiece.AIFF")
        } else {
            Issue.record("Expected .soundFileName case")
        }
    }

    @Test
    func statsLine() {
        let command = DKMCommand.statsLine(DKMStatsLine(startBeat: 0.0, duration: 5.0))

        if case let .statsLine(line) = command {
            #expect(line.startBeat == 0.0)
            #expect(line.duration == 5.0)
        } else {
            Issue.record("Expected .statsLine case")
        }
    }

    @Test
    func tempoLine() {
        let command = DKMCommand.tempoLine(DKMTempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0))

        if case let .tempoLine(line) = command {
            #expect(line.startBeat == 0.0)
            #expect(line.duration == 1.0)
            #expect(line.initialTempo == 57.0)
            #expect(line.finalTempo == 57.0)
        } else {
            Issue.record("Expected .tempoLine case")
        }
    }

    @Test
    func tuning() {
        let command = DKMCommand.tuning(DKMTuning(primaryInterval: 1.0,
                                                  notesPerInterval: 19.0,
                                                  pitchConvExponent: 3.0,
                                                  pitchConvFactor: 1.021974864))

        if case let .tuning(tuning) = command {
            #expect(tuning.primaryInterval == 1.0)
            #expect(tuning.notesPerInterval == 19.0)
            #expect(tuning.pitchConvExponent == 3.0)
            #expect(tuning.pitchConvFactor == 1.021974864)
        } else {
            Issue.record("Expected .tuning case")
        }
    }

    @Test
    func vocodeMode() {
        let command = DKMCommand.vocodeMode(DKMVocodeMode(channel: .right,
                                                          name: "ExtSound",
                                                          clipRate: 1.0,
                                                          maxHarm: 0,
                                                          slope: 2.2,
                                                          bassBoost: 4.0,
                                                          dynExponent: 1.1,
                                                          shiftN: 0,
                                                          peakReduction: 3.0))

        if case let .vocodeMode(mode) = command {
            #expect(mode.channel == .right)
            #expect(mode.name == "ExtSound")
            #expect(mode.clipRate == 1.0)
            #expect(mode.maxHarm == 0)
            #expect(mode.slope == 2.2)
            #expect(mode.bassBoost == 4.0)
            #expect(mode.dynExponent == 1.1)
            #expect(mode.shiftN == 0)
            #expect(mode.peakReduction == 3.0)
        } else {
            Issue.record("Expected .vocodeMode case")
        }
    }

    @Test
    func vocodeNote() {
        let command = DKMCommand.vocodeNote(DKMVocodeNote(startBeat: 5.1,
                                                          duration: 2.2,
                                                          volume: 5.0,
                                                          location: -0.5,
                                                          pitch: -120.0,
                                                          clipStart: 1.1,
                                                          instrument: "VanON"))

        if case let .vocodeNote(note) = command {
            #expect(note.startBeat == 5.1)
            #expect(note.duration == 2.2)
            #expect(note.volume == 5.0)
            #expect(note.location == -0.5)
            #expect(note.pitch == -120.0)
            #expect(note.clipStart == 1.1)
            #expect(note.instrument == "VanON")
        } else {
            Issue.record("Expected .vocodeNote case")
        }
    }
}
