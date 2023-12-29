//
//  AudioPlayer+Loudness.swift
//  
//
//  Created by Andreas Ink on 12/29/23.
//

import SwiftUI
import AVFAudio

@available(iOS 13.0, *)
public extension AudioPlayer {
    
    func streamOutputBuffer() {
        let mixerNode = audioEngine.mainMixerNode
        let format = mixerNode.outputFormat(forBus: 0) // Use the mixer's output format.
        
        bufferStream = AsyncStream<AVAudioPCMBuffer> { continuation in
            mixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time) in
                // Yield the buffer to the stream.
                continuation.yield(buffer)
            }
            
            // Handle cancellation.
            continuation.onTermination = { @Sendable _ in
                mixerNode.removeTap(onBus: 0)
            }
        }
    }
}
