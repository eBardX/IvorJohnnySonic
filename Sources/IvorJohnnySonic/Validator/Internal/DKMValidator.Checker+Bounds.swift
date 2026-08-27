// © 2026 John Gary Pusey (see LICENSE.md)

// The parameter bounds below are the ones the reference implementation
// repairs by inventing a replacement value (`MyWarn` and clamp), rather than
// by restoring one already known (a job ``DKMNormalizer`` does instead).

extension DKMValidator.Checker {

    // MARK: Internal Instance Methods

    // main.c: ProcessCompress line 2168 (maxRatio < 2)
    internal mutating func checkCompressMaxRatio(_ maxRatio: Double,
                                                 at index: Int) {
        guard maxRatio < 2
        else { return }

        issues.append(.parameterOutOfRange(commandIndex: index, parameter: "maxRatio", value: maxRatio))
    }

    // main.c: ProcessFlange line 1746 (depth >= numberOfVoices)
    internal mutating func checkFlangeDepth(_ depth: Double,
                                            numberOfVoices: Int,
                                            at index: Int) {
        guard depth >= Double(numberOfVoices)
        else { return }

        issues.append(.parameterOutOfRange(commandIndex: index, parameter: "depth", value: depth))
    }

    // main.c: ProcessHaas line 2227 (minDelay ∉ [0, 40], maxDelay ∉ [0, 90])
    internal mutating func checkHaasDelays(minDelay: Double,
                                           maxDelay: Double,
                                           at index: Int) {
        if !(0...40).contains(minDelay) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "minDelay", value: minDelay))
        }

        if !(0...90).contains(maxDelay) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "maxDelay", value: maxDelay))
        }
    }

    // main.c: ProcessReverb line 2618 (reverbTime < 0, combFilterDryGain/xTalkFactor/wetness ∉ [0, 1])
    internal mutating func checkReverbParameters(reverbTime: Double,
                                                 combFilterDryGain: Double,
                                                 xTalkFactor: Double,
                                                 wetness: Double,
                                                 at index: Int) {
        if reverbTime < 0 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "reverbTime", value: reverbTime))
        }

        if !(0...1).contains(combFilterDryGain) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "combFilterDryGain", value: combFilterDryGain))
        }

        if !(0...1).contains(xTalkFactor) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "xTalkFactor", value: xTalkFactor))
        }

        if !(0...1).contains(wetness) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "wetness", value: wetness))
        }
    }

    // main.c: ProcessTempo line 1688 (a zero or negative tempo divides the beat-time map)
    internal mutating func checkTempoValues(initialTempo: Double,
                                            finalTempo: Double,
                                            at index: Int) {
        if initialTempo <= 0 {
            issues.append(.nonPositiveTempo(commandIndex: index, tempo: initialTempo))
        }

        if finalTempo <= 0 {
            issues.append(.nonPositiveTempo(commandIndex: index, tempo: finalTempo))
        }
    }

    // main.c: ProcessTuning line 2204 (primaryInterval/notesPerInterval <= 1, pitchConvExponent/pitchConvFactor <= 0)
    internal mutating func checkTuningParameters(_ tuning: DKMTuning,
                                                 at index: Int) {
        if tuning.primaryInterval <= 1 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "primaryInterval", value: tuning.primaryInterval))
        }

        if tuning.notesPerInterval <= 1 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "notesPerInterval", value: tuning.notesPerInterval))
        }

        if tuning.pitchConvExponent <= 0 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "pitchConvExponent", value: tuning.pitchConvExponent))
        }

        if tuning.pitchConvFactor <= 0 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "pitchConvFactor", value: tuning.pitchConvFactor))
        }
    }

    // main.c: ProcessVocode line 2733 (clipRate == 0; dynExponent ∉ [0.25, 4.0]; slope ∉ [−8, 8];
    // bassBoost ∉ [−15, 15]; shiftN ∉ [−kVocoderNumFreqBands, kVocoderNumFreqBands] (128, not the
    // documented 16 — js.h: kVocoderNumFreqBands = kSamplesInVocoderFFT / (2 * kVocoderFreqBandSize));
    // peakReduction ∉ [0, 12])
    internal mutating func checkVocodeModeParameters(_ mode: DKMVocodeMode,
                                                     at index: Int) {
        if mode.clipRate == 0 {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "clipRate", value: mode.clipRate))
        }

        if !(0.25...4.0).contains(mode.dynExponent) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "dynExponent", value: mode.dynExponent))
        }

        if !(-8.0...8.0).contains(mode.slope) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "slope", value: mode.slope))
        }

        if !(-15.0...15.0).contains(mode.bassBoost) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "bassBoost", value: mode.bassBoost))
        }

        if !(-128...128).contains(mode.shiftN) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "shiftN", value: Double(mode.shiftN)))
        }

        if !(0...12).contains(mode.peakReduction) {
            issues.append(.parameterOutOfRange(commandIndex: index, parameter: "peakReduction", value: mode.peakReduction))
        }
    }
}
