#include "SoundpipeDSPBase.h"
#include "ParameterRamper.h"
#include "Soundpipe.h"

enum FrequencyTrackerParameter : AUParameterAddress {
//    FrequencyTrackerParameterFrequency
};

class FrequencyTrackerDSP : public SoundpipeDSPBase {
private:
    sp_data *sp;
    sp_ptrack *ptrack;

    
public:
    float trackedAmplitude = 0.0;
    float trackedFrequency = 0.0;
    
    FrequencyTrackerDSP() {
    }
    
    void init(int channelCount, double sampleRate) override {
        SoundpipeDSPBase::init(channelCount, sampleRate);
        
        sp_create(&sp);
        sp->sr = (int)sampleRate;
        sp->nchan = channelCount;
        
        sp_ptrack_create(&ptrack);
        sp_ptrack_init(sp, ptrack, 1024, 20);
    }
    
    void deinit() override {
        SoundpipeDSPBase::deinit();
        sp_ptrack_destroy(&ptrack);
    }

    
    // Uses the ParameterAddress as a key
    void setParameter(AUParameterAddress address, AUValue value, bool immediate) override {
        switch (address) {
            default:
                DSPBase::setParameter(address, value, immediate);
        }
    }
    
    // Uses the ParameterAddress as a key
    float getParameter(AUParameterAddress address) override {
        switch (address) {
            default:
                return DSPBase::getParameter(address);
        }
    }
    
    void startRamp(const AUParameterEvent &event) override {
        auto address = event.parameterAddress;
        switch (address) {
            default:
                DSPBase::startRamp(event);
        }
    }
    
    void process(FrameRange range) override {
        for(auto i : range) {
            float leftIn = inputSample(0, i);
            float &leftOut = outputSample(0, i);
            sp_ptrack_compute(sp, ptrack, &leftIn, &trackedFrequency, &trackedAmplitude);
            
            if(trackedAmplitude < 0.04) {
                trackedFrequency = 0;
            }
            
            float rightIn = inputSample(1, i);
            float& rightOut = outputSample(1, i);
            rightOut = rightIn;
        }
    }
};

AK_API float akFrequencyTrackerGetFrequency(DSPRef dspRef) {
    auto dsp = dynamic_cast<FrequencyTrackerDSP *>(dspRef);
    assert(dsp);
    return dsp->trackedFrequency;
}

AK_REGISTER_DSP(FrequencyTrackerDSP, "ptrk")

//AK_REGISTER_PARAMETER(FaderParameterLeftGain)
//AK_REGISTER_PARAMETER(FaderParameterRightGain)
//AK_REGISTER_PARAMETER(FaderParameterFlipStereo)
//AK_REGISTER_PARAMETER(FaderParameterMixToMono)
