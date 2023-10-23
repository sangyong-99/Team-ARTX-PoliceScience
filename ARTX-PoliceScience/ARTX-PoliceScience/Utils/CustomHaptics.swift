//
//  CustomHaptics.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/19/23.
//

import CoreHaptics
import UIKit

class CustomHaptics {
    static let shared = CustomHaptics()
    var engine: CHHapticEngine?
    
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            NotificationCenter.default.addObserver(self, selector: #selector(restartEngine), name: UIApplication.didBecomeActiveNotification, object: nil)
        } catch {
            print("Haptic engine not supported")
        }
    }
    
    @objc func restartEngine() {
        guard let engine = engine else { return }
        do {
            try engine.start()
        } catch {
            print("Haptic engine not restarted")
        }
    }
    
    func oxTapped() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
        let events = [CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)]
        
        startEvents(events)
    }
    
    func oxUntapped() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let events = [CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)]
        
        startEvents(events)
    }
    
    func bookMarkTapped() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let events = [CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)]
        
        startEvents(events)
    }
    
    private func startEvents(_ events: [CHHapticEvent]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic")
        }
    }
}
