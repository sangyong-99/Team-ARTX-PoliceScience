//
//  LocalState.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import Foundation

public class LocalState {
    private enum Keys: String {
        case isCodeActivated
    }
    
    public static var isCodeActivated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isCodeActivated.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isCodeActivated.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
