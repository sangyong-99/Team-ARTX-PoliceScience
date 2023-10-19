//
//  CustomHaptics.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/19/23.
//

import CoreHaptics

struct CustomHaptics {
    static let shared = CustomHaptics()
    var engine: CHHapticEngine?
    
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine not supported")
        }
    }
    
    func oxButtonPressed() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
        let events = [CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)]
        
        startEvents(events)
    }
    
    func oxButtonUnpressed() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let events = [CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)]
        
        startEvents(events)
    }
    
    func bookMarkPressed() {
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
