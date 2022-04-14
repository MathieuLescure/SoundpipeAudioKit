// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

#pragma once

#import "SoundpipeDSPBase.h"

// Analysis
#import "PitchTracker.h"

// Custom interop
AK_API void akCombFilterReverbSetLoopDuration(DSPRef dsp, float duration);
AK_API void akConvolutionSetPartitionLength(DSPRef dsp, int length);
AK_API void akFlatFrequencyResponseSetLoopDuration(DSPRef dsp, float duration);
AK_API void akVariableDelaySetMaximumTime(DSPRef dsp, float maximumTime);
AK_API float akFrequencyTrackerGetFrequency(DSPRef dspRef);
AK_API float akFrequencyTrackerGetAmplitude(DSPRef dspRef);
AK_API unsigned int akFrequencyTrackerGetMeasureCounter(DSPRef dspRef);
