//
//  SwiftUIView.swift
//  
//
//  Created by Andreas Ink on 12/29/23.
//

import SwiftUI

public extension AudioPlayer: ObservableObject {
    
    @Published public var scale: CGFloat = 1
    
    public func startMonitoringLoudness() {
        let mixerNode = audioEngine.mainMixerNode
        let format = mixerNode.outputFormat(forBus: 0) // Use the mixer's output format.
        
        mixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] (buffer, time) in
            self?.processAudioBuffer(buffer)
        }
    }
    
    func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        // Calculate the loudness from the buffer.
        var rms: Float = 0.0
        if let channelData = buffer.floatChannelData {
            for frame in 0..<Int(buffer.frameLength) {
                let sample = channelData.pointee[frame]
                rms += sample * sample
            }
            rms = sqrt(rms / Float(buffer.frameLength))

            // Map the loudness to a scale factor.
            let newScale = CGFloat(1.0 + (rms * 0.5))
            DispatchQueue.main.async {
                self.scale = newScale
            }
        }
    }
}
