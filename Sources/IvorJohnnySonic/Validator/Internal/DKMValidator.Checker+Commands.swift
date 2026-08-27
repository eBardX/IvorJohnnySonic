// © 2026 John Gary Pusey (see LICENSE.md)

extension DKMValidator.Checker {

    // MARK: Internal Instance Methods

    internal mutating func checkBeat(_ beat: Double,
                                     at index: Int) {
        guard beat > 8_192
        else { return }

        issues.append(.beatExceedsTableSize(commandIndex: index, beat: beat))
    }

    internal mutating func checkChorusLine(_ line: DKMChorusLine,
                                           at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.depth, parameter: "depth", at: index)
    }

    internal mutating func checkClipMode(_ mode: DKMClipMode,
                                         at index: Int) {
        checkNoWhitespaceName(mode.name, at: index)

        sawClipMode = true
    }

    internal mutating func checkClipNote(_ note: DKMClipNote,
                                         at index: Int) {
        checkSegment(startBeat: note.startBeat, duration: note.duration, at: index)
        checkFinite(note.volume, parameter: "volume", at: index)
        checkFinite(note.location, parameter: "location", at: index)
        checkFinite(note.clipStart, parameter: "clipStart", at: index)
        checkFinite(note.clipRate, parameter: "clipRate", at: index)
        checkNoWhitespaceName(note.instrument, at: index)

        if !sawClipMode, !sawInclude {
            issues.append(.clipNoteWithoutMode(commandIndex: index))
        }
    }

    internal mutating func checkCompressLine(_ line: DKMCompressLine,
                                             at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.maxRatio, parameter: "maxRatio", at: index)
        checkCompressMaxRatio(line.maxRatio, at: index)
    }

    internal mutating func checkFilterLine(_ line: DKMFilterLine,
                                           at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.initialPitch, parameter: "initialPitch", at: index)
        checkFinite(line.finalPitch, parameter: "finalPitch", at: index)
        checkFinite(line.initialBandwidth, parameter: "initialBandwidth", at: index)
        checkFinite(line.finalBandwidth, parameter: "finalBandwidth", at: index)
    }

    internal mutating func checkFinite(_ value: Double,
                                       parameter: String,
                                       at index: Int) {
        guard !value.isFinite
        else { return }

        issues.append(.nonFiniteParameter(commandIndex: index, parameter: parameter))
    }

    internal mutating func checkFlangeLine(_ line: DKMFlangeLine,
                                           at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.depth, parameter: "depth", at: index)
        checkFlangeDepth(line.depth, numberOfVoices: line.numberOfVoices, at: index)
    }

    internal mutating func checkFreqBandAnalyzeLine(_ line: DKMFreqBandAnalyzeLine,
                                                    at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
    }

    internal mutating func checkGEQBandGains(_ bandGains: [Double],
                                             at index: Int) {
        if bandGains.contains(where: { !$0.isFinite }) {
            issues.append(.nonFiniteParameter(commandIndex: index, parameter: "bandGains"))
        }

        guard bandGains.count > 30
        else { return }

        issues.append(.invalidBandGainCount(commandIndex: index, count: bandGains.count))
    }

    internal mutating func checkGEQLine(_ line: DKMGEQLine,
                                        at index: Int,
                                        incompleteGEQIndices: Set<Int>) {
        checkFinite(line.beat, parameter: "beat", at: index)
        checkBeat(line.beat, at: index)
        checkGEQBandGains(line.bandGains, at: index)

        if incompleteGEQIndices.contains(index) {
            issues.append(.incompleteGraphicEQSegment(commandIndex: index))
        }
    }

    internal mutating func checkHaas(_ haas: DKMHaas,
                                     at index: Int) {
        checkFinite(haas.minDelay, parameter: "minDelay", at: index)
        checkFinite(haas.maxDelay, parameter: "maxDelay", at: index)
        checkHaasDelays(minDelay: haas.minDelay, maxDelay: haas.maxDelay, at: index)
    }

    internal mutating func checkInclude(_ fileName: String,
                                        at index: Int) {
        checkNoNewlineName(fileName, at: index)

        sawInclude = true
    }

    internal mutating func checkLevelsLine(_ line: DKMLevelsLine,
                                           at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.startGainLossdB, parameter: "startGainLossdB", at: index)
        checkFinite(line.endGainLossdB, parameter: "endGainLossdB", at: index)
    }

    internal mutating func checkMixLine(_ line: DKMMixLine,
                                        at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.gainLossdB, parameter: "gainLossdB", at: index)
        checkFinite(line.sign, parameter: "sign", at: index)
        checkFinite(line.timeOffset, parameter: "timeOffset", at: index)
    }

    internal mutating func checkNoNewlineName(_ name: String,
                                              at index: Int) {
        guard name.isEmpty || name.contains(where: \.isNewline)
        else { return }

        issues.append(.unwritableName(commandIndex: index, name: name))
    }

    internal mutating func checkNoWhitespaceName(_ name: String,
                                                 at index: Int) {
        guard name.isEmpty || name.contains(where: \.isWhitespace)
        else { return }

        issues.append(.unwritableName(commandIndex: index, name: name))
    }

    internal mutating func checkPitchesNote(_ note: DKMPitchesNote,
                                            at index: Int) {
        checkSegment(startBeat: note.startBeat, duration: note.duration, at: index)
        checkFinite(note.volume, parameter: "volume", at: index)
        checkFinite(note.location, parameter: "location", at: index)
        checkFinite(note.startPitch, parameter: "startPitch", at: index)
        checkFinite(note.endPitch, parameter: "endPitch", at: index)
        checkNoWhitespaceName(note.instrument, at: index)

        // main.c: ProcessPitches clears both `playingClip` and `vocoding`, so
        // a `/PIT` header between a `/CLI` block and a later clip (or vocode)
        // note does invalidate it.
        sawClipMode = false
        sawVocodeMode = false
    }

    internal mutating func checkPositiveDuration(_ duration: Double,
                                                 at index: Int) {
        guard duration <= 0
        else { return }

        issues.append(.nonPositiveDuration(commandIndex: index, duration: duration))
    }

    internal mutating func checkPulseLine(_ line: DKMPulseLine,
                                          at index: Int) {
        checkFinite(line.startBeat, parameter: "startBeat", at: index)
        checkBeat(line.startBeat, at: index)
    }

    internal mutating func checkReverbLine(_ line: DKMReverbLine,
                                           at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.reverbTime, parameter: "reverbTime", at: index)
        checkFinite(line.combFilterDryGain, parameter: "combFilterDryGain", at: index)
        checkFinite(line.xTalkFactor, parameter: "xTalkFactor", at: index)
        checkFinite(line.wetness, parameter: "wetness", at: index)
        checkReverbParameters(reverbTime: line.reverbTime,
                              combFilterDryGain: line.combFilterDryGain,
                              xTalkFactor: line.xTalkFactor,
                              wetness: line.wetness,
                              at: index)
    }

    internal mutating func checkSegment(startBeat: Double,
                                        duration: Double,
                                        at index: Int) {
        checkFinite(startBeat, parameter: "startBeat", at: index)
        checkFinite(duration, parameter: "duration", at: index)
        checkPositiveDuration(duration, at: index)
        checkBeat(startBeat, at: index)
        checkBeat(startBeat + duration, at: index)
    }

    internal mutating func checkSendBackLine(_ line: DKMSendBackLine,
                                             at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.gainLossdB, parameter: "gainLossdB", at: index)
    }

    internal mutating func checkShowBufferLine(_ line: DKMShowBufferLine,
                                               at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
    }

    internal mutating func checkSoundFileName(_ name: String,
                                              at index: Int) {
        checkNoNewlineName(name, at: index)
    }

    internal mutating func checkStatsLine(_ line: DKMStatsLine,
                                          at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
    }

    internal mutating func checkTempoLine(_ line: DKMTempoLine,
                                          at index: Int) {
        checkSegment(startBeat: line.startBeat, duration: line.duration, at: index)
        checkFinite(line.initialTempo, parameter: "initialTempo", at: index)
        checkFinite(line.finalTempo, parameter: "finalTempo", at: index)
        checkTempoValues(initialTempo: line.initialTempo, finalTempo: line.finalTempo, at: index)
    }

    internal mutating func checkTuning(_ tuning: DKMTuning,
                                       at index: Int) {
        checkFinite(tuning.primaryInterval, parameter: "primaryInterval", at: index)
        checkFinite(tuning.notesPerInterval, parameter: "notesPerInterval", at: index)
        checkFinite(tuning.pitchConvExponent, parameter: "pitchConvExponent", at: index)
        checkFinite(tuning.pitchConvFactor, parameter: "pitchConvFactor", at: index)
        checkTuningParameters(tuning, at: index)
    }

    internal mutating func checkVocodeMode(_ mode: DKMVocodeMode,
                                           at index: Int) {
        checkFinite(mode.clipRate, parameter: "clipRate", at: index)
        checkFinite(mode.slope, parameter: "slope", at: index)
        checkFinite(mode.bassBoost, parameter: "bassBoost", at: index)
        checkFinite(mode.dynExponent, parameter: "dynExponent", at: index)
        checkFinite(mode.peakReduction, parameter: "peakReduction", at: index)
        checkNoWhitespaceName(mode.name, at: index)
        checkVocodeModeParameters(mode, at: index)

        sawVocodeMode = true
    }

    internal mutating func checkVocodeNote(_ note: DKMVocodeNote,
                                           at index: Int) {
        checkSegment(startBeat: note.startBeat, duration: note.duration, at: index)
        checkFinite(note.volume, parameter: "volume", at: index)
        checkFinite(note.location, parameter: "location", at: index)
        checkFinite(note.pitch, parameter: "pitch", at: index)
        checkFinite(note.clipStart, parameter: "clipStart", at: index)
        checkNoWhitespaceName(note.instrument, at: index)

        if !sawVocodeMode, !sawInclude {
            issues.append(.vocodeNoteWithoutMode(commandIndex: index))
        }
    }
}
