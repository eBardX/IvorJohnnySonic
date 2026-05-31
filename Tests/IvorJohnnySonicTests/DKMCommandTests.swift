// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMCommandTests {
}

// MARK: -

extension DKMCommandTests {
    @Test
    func chorusLine() {
        let command = DKMCommand.chorusLine(startBeat: 8.0,
                                            duration: 12.5,
                                            numberOfVoices: 4,
                                            depth: 0.9,
                                            flipChannels: false)

        if case let .chorusLine(startBeat, duration, numberOfVoices, depth, flipChannels) = command {
            #expect(startBeat == 8.0)
            #expect(duration == 12.5)
            #expect(numberOfVoices == 4)
            #expect(depth == 0.9)
            #expect(flipChannels == false)
        } else {
            Issue.record("Expected .chorusLine case")
        }
    }

    @Test
    func clipMode() {
        let command = DKMCommand.clipMode(channel: .right, name: "ExtSound")

        if case let .clipMode(channel, name) = command {
            #expect(channel == .right)
            #expect(name == "ExtSound")
        } else {
            Issue.record("Expected .clipMode case")
        }
    }

    @Test
    func clipNote() {
        let command = DKMCommand.clipNote(startBeat: 5.1,
                                          duration: 2.2,
                                          volume: 5.0,
                                          location: 0.5,
                                          clipStart: 0.1,
                                          clipRate: 1.1,
                                          instrument: "ClipTest")

        if case let .clipNote(startBeat, duration, volume, location, clipStart, clipRate, instrument) = command {
            #expect(startBeat == 5.1)
            #expect(duration == 2.2)
            #expect(volume == 5.0)
            #expect(location == 0.5)
            #expect(clipStart == 0.1)
            #expect(clipRate == 1.1)
            #expect(instrument == "ClipTest")
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
        let command = DKMCommand.compressLine(startBeat: 5.0, duration: 10.0, maxRatio: 8.0)

        if case let .compressLine(startBeat, duration, maxRatio) = command {
            #expect(startBeat == 5.0)
            #expect(duration == 10.0)
            #expect(maxRatio == 8.0)
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
        let command = DKMCommand.filterLine(startBeat: 8.0,
                                            duration: 20.0,
                                            filterType: .butterworthBandpass,
                                            initialPitch: -550.0,
                                            finalPitch: -550.0,
                                            initialBandwidth: -80.0,
                                            finalBandwidth: -80.0)

        if case let .filterLine(startBeat, duration, filterType, initialPitch, finalPitch, initialBandwidth, finalBandwidth) = command {
            #expect(startBeat == 8.0)
            #expect(duration == 20.0)
            #expect(filterType == .butterworthBandpass)
            #expect(initialPitch == -550.0)
            #expect(finalPitch == -550.0)
            #expect(initialBandwidth == -80.0)
            #expect(finalBandwidth == -80.0)
        } else {
            Issue.record("Expected .filterLine case")
        }
    }

    @Test
    func flangeLine() {
        let command = DKMCommand.flangeLine(startBeat: 2.0,
                                            duration: 5.0,
                                            numberOfVoices: 2,
                                            depth: 0.8,
                                            flipChannels: true)

        if case let .flangeLine(startBeat, duration, numberOfVoices, depth, flipChannels) = command {
            #expect(startBeat == 2.0)
            #expect(duration == 5.0)
            #expect(numberOfVoices == 2)
            #expect(depth == 0.8)
            #expect(flipChannels == true)
        } else {
            Issue.record("Expected .flangeLine case")
        }
    }

    @Test
    func freqBandAnalyzeLine() {
        let command = DKMCommand.freqBandAnalyzeLine(startBeat: 1.0,
                                                     duration: 2.0,
                                                     channel: .combined,
                                                     buffer: .mix)

        if case let .freqBandAnalyzeLine(startBeat, duration, channel, buffer) = command {
            #expect(startBeat == 1.0)
            #expect(duration == 2.0)
            #expect(channel == .combined)
            #expect(buffer == .mix)
        } else {
            Issue.record("Expected .freqBandAnalyzeLine case")
        }
    }

    @Test
    func geqLine() {
        let command = DKMCommand.geqLine(beat: 15.0, bandGains: [3.0, 2.0, 0.0, -5.0])

        if case let .geqLine(beat, bandGains) = command {
            #expect(beat == 15.0)
            #expect(bandGains == [3.0, 2.0, 0.0, -5.0])
        } else {
            Issue.record("Expected .geqLine case")
        }
    }

    @Test
    func haas() {
        let command = DKMCommand.haas(enabled: true, minDelay: 20.0, maxDelay: 50.0, reverbSend: false)

        if case let .haas(enabled, minDelay, maxDelay, reverbSend) = command {
            #expect(enabled == true)
            #expect(minDelay == 20.0)
            #expect(maxDelay == 50.0)
            #expect(reverbSend == false)
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
    func levelsLine() {
        let command = DKMCommand.levelsLine(startBeat: 5.0,
                                            duration: 10.0,
                                            startGainLossdB: -3.0,
                                            endGainLossdB: 0.0)

        if case let .levelsLine(startBeat, duration, startGainLossdB, endGainLossdB) = command {
            #expect(startBeat == 5.0)
            #expect(duration == 10.0)
            #expect(startGainLossdB == -3.0)
            #expect(endGainLossdB == 0.0)
        } else {
            Issue.record("Expected .levelsLine case")
        }
    }

    @Test
    func mixLine() {
        let command = DKMCommand.mixLine(startBeat: 0.0,
                                         duration: 10.0,
                                         gainLossdB: 0.0,
                                         keepSoundBuffer: false,
                                         sign: 1.0,
                                         timeOffset: 0.0)

        if case let .mixLine(startBeat, duration, gainLossdB, keepSoundBuffer, sign, timeOffset) = command {
            #expect(startBeat == 0.0)
            #expect(duration == 10.0)
            #expect(gainLossdB == 0.0)
            #expect(keepSoundBuffer == false)
            #expect(sign == 1.0)
            #expect(timeOffset == 0.0)
        } else {
            Issue.record("Expected .mixLine case")
        }
    }

    @Test
    func pitchesNote() {
        let command = DKMCommand.pitchesNote(startBeat: 5.1,
                                             duration: 2.2,
                                             volume: 5.0,
                                             location: 0.5,
                                             startPitch: 47.0,
                                             endPitch: 47.0,
                                             instrument: "FiltNz0")

        if case let .pitchesNote(startBeat, duration, volume, location, startPitch, endPitch, instrument) = command {
            #expect(startBeat == 5.1)
            #expect(duration == 2.2)
            #expect(volume == 5.0)
            #expect(location == 0.5)
            #expect(startPitch == 47.0)
            #expect(endPitch == 47.0)
            #expect(instrument == "FiltNz0")
        } else {
            Issue.record("Expected .pitchesNote case")
        }
    }

    @Test
    func pulseLine() {
        let command = DKMCommand.pulseLine(startBeat: 10.0, channel: .left)

        if case let .pulseLine(startBeat, channel) = command {
            #expect(startBeat == 10.0)
            #expect(channel == .left)
        } else {
            Issue.record("Expected .pulseLine case")
        }
    }

    @Test
    func reverbLine() {
        let command = DKMCommand.reverbLine(startBeat: 8.8,
                                            duration: 12.0,
                                            direction: .forward,
                                            size: .large,
                                            reverbTime: 1.2,
                                            combFilterDryGain: 0.8,
                                            xTalkFactor: 0.2,
                                            wetness: 0.6)

        if case let .reverbLine(startBeat, duration, direction, size, reverbTime, combFilterDryGain, xTalkFactor, wetness) = command {
            #expect(startBeat == 8.8)
            #expect(duration == 12.0)
            #expect(direction == .forward)
            #expect(size == .large)
            #expect(reverbTime == 1.2)
            #expect(combFilterDryGain == 0.8)
            #expect(xTalkFactor == 0.2)
            #expect(wetness == 0.6)
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
        let command = DKMCommand.sendBackLine(startBeat: 5.0, duration: 10.0, gainLossdB: -6.0)

        if case let .sendBackLine(startBeat, duration, gainLossdB) = command {
            #expect(startBeat == 5.0)
            #expect(duration == 10.0)
            #expect(gainLossdB == -6.0)
        } else {
            Issue.record("Expected .sendBackLine case")
        }
    }

    @Test
    func showBufferLine() {
        let command = DKMCommand.showBufferLine(startBeat: 1.0, duration: 2.0)

        if case let .showBufferLine(startBeat, duration) = command {
            #expect(startBeat == 1.0)
            #expect(duration == 2.0)
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
        let command = DKMCommand.statsLine(startBeat: 0.0, duration: 5.0)

        if case let .statsLine(startBeat, duration) = command {
            #expect(startBeat == 0.0)
            #expect(duration == 5.0)
        } else {
            Issue.record("Expected .statsLine case")
        }
    }

    @Test
    func tempoLine() {
        let command = DKMCommand.tempoLine(startBeat: 0.0, duration: 1.0, initialTempo: 57.0, finalTempo: 57.0)

        if case let .tempoLine(startBeat, duration, initialTempo, finalTempo) = command {
            #expect(startBeat == 0.0)
            #expect(duration == 1.0)
            #expect(initialTempo == 57.0)
            #expect(finalTempo == 57.0)
        } else {
            Issue.record("Expected .tempoLine case")
        }
    }

    @Test
    func tuning() {
        let command = DKMCommand.tuning(primaryInterval: 1.0,
                                        notesPerInterval: 19.0,
                                        pitchConvExponent: 3.0,
                                        pitchConvFactor: 1.021974864)

        if case let .tuning(primaryInterval, notesPerInterval, pitchConvExponent, pitchConvFactor) = command {
            #expect(primaryInterval == 1.0)
            #expect(notesPerInterval == 19.0)
            #expect(pitchConvExponent == 3.0)
            #expect(pitchConvFactor == 1.021974864)
        } else {
            Issue.record("Expected .tuning case")
        }
    }

    @Test
    func vocodeMode() {
        let command = DKMCommand.vocodeMode(channel: .right,
                                            name: "ExtSound",
                                            clipRate: 1.0,
                                            maxHarm: 0,
                                            slope: 2.2,
                                            bassBoost: 4.0,
                                            dynExponent: 1.1,
                                            shiftN: 0,
                                            peakReduction: 3.0)

        if case let .vocodeMode(channel, name, clipRate, maxHarm, slope, bassBoost, dynExponent, shiftN, peakReduction) = command {
            #expect(channel == .right)
            #expect(name == "ExtSound")
            #expect(clipRate == 1.0)
            #expect(maxHarm == 0)
            #expect(slope == 2.2)
            #expect(bassBoost == 4.0)
            #expect(dynExponent == 1.1)
            #expect(shiftN == 0)
            #expect(peakReduction == 3.0)
        } else {
            Issue.record("Expected .vocodeMode case")
        }
    }

    @Test
    func vocodeNote() {
        let command = DKMCommand.vocodeNote(startBeat: 5.1,
                                            duration: 2.2,
                                            volume: 5.0,
                                            location: -0.5,
                                            pitch: -120.0,
                                            clipStart: 1.1,
                                            instrument: "VanON")

        if case let .vocodeNote(startBeat, duration, volume, location, pitch, clipStart, instrument) = command {
            #expect(startBeat == 5.1)
            #expect(duration == 2.2)
            #expect(volume == 5.0)
            #expect(location == -0.5)
            #expect(pitch == -120.0)
            #expect(clipStart == 1.1)
            #expect(instrument == "VanON")
        } else {
            Issue.record("Expected .vocodeNote case")
        }
    }
}

// MARK: - DKMChannel

extension DKMCommandTests {
    @Test
    func channelRawValues() {
        #expect(DKMChannel.both.rawValue == "B")
        #expect(DKMChannel.left.rawValue == "L")
        #expect(DKMChannel.right.rawValue == "R")
    }
}

// MARK: - DKMClipChannel

extension DKMCommandTests {
    @Test
    func clipChannelRawValues() {
        #expect(DKMClipChannel.left.rawValue == 0)
        #expect(DKMClipChannel.right.rawValue == 1)
    }
}

// MARK: - DKMFBABuffer

extension DKMCommandTests {
    @Test
    func fbaBufferRawValues() {
        #expect(DKMFBABuffer.mix.rawValue == "M")
        #expect(DKMFBABuffer.sound.rawValue == "S")
    }
}

// MARK: - DKMFBAChannel

extension DKMCommandTests {
    @Test
    func fbaChannelRawValues() {
        #expect(DKMFBAChannel.combined.rawValue == -1)
        #expect(DKMFBAChannel.left.rawValue == 0)
        #expect(DKMFBAChannel.right.rawValue == 1)
    }
}

// MARK: - DKMFilterType

extension DKMCommandTests {
    @Test
    func filterTypeRawValues() {
        #expect(DKMFilterType.allPoleBandpassZeroDBGain.rawValue == 1)
        #expect(DKMFilterType.allPoleBandpassPowerPreserving.rawValue == 2)
        #expect(DKMFilterType.butterworthLowpass.rawValue == 3)
        #expect(DKMFilterType.butterworthHighpass.rawValue == 4)
        #expect(DKMFilterType.butterworthBandpass.rawValue == 5)
        #expect(DKMFilterType.butterworthNotch.rawValue == 6)
        #expect(DKMFilterType.firLowpass.rawValue == 13)
        #expect(DKMFilterType.firHighpass.rawValue == 14)
        #expect(DKMFilterType.firNotch.rawValue == 16)
    }
}

// MARK: - DKMReverbDirection

extension DKMCommandTests {
    @Test
    func reverbDirectionRawValues() {
        #expect(DKMReverbDirection.backward.rawValue == -1)
        #expect(DKMReverbDirection.forward.rawValue == 1)
    }
}

// MARK: - DKMReverbSize

extension DKMCommandTests {
    @Test
    func reverbSizeRawValues() {
        #expect(DKMReverbSize.small.rawValue == 1)
        #expect(DKMReverbSize.medium.rawValue == 2)
        #expect(DKMReverbSize.large.rawValue == 3)
    }
}

// MARK: - DKMScreenLevel

extension DKMCommandTests {
    @Test
    func screenLevelRawValues() {
        #expect(DKMScreenLevel.quiet.rawValue == 0)
        #expect(DKMScreenLevel.medium.rawValue == 1)
        #expect(DKMScreenLevel.verbose.rawValue == 2)
        #expect(DKMScreenLevel.debug.rawValue == 3)
    }
}
