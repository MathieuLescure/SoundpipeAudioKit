//
//  AKFrequencyTracker.swift
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import AVFoundation
import AudioKit
import AudioKitEX
import CAudioKitEX
import CSoundpipeAudioKit

/// This is based on an algorithm originally created by Miller Puckette.
///
open class FrequencyTracker: Node {
    let input: Node
    public var connections: [Node] { [input] }
    public var avAudioNode = instantiate(effect: "ptrk")
    
    public var frequency: Float {
        akFrequencyTrackerGetFrequency(au.dsp)
    }
    
    public var amplitude: Float {
        akFrequencyTrackerGetAmplitude(au.dsp)
    }
    
    public var measureCounter: UInt32 {
        akFrequencyTrackerGetMeasureCounter(au.dsp)
    }

    // MARK: - Initialization

    /// Initialize this Pitch-tracker node
    ///
    /// - parameter input: Input node to process
    /// - parameter hopSize: Hop size.
    /// - parameter peakCount: Number of peaks.
    ///
    public init(_ input: Node) {
        self.input = input
        setupParameters()
    }

}
