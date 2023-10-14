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
        case authenticationCode
        case bookmark
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
    
    public static var authenticationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.authenticationCode.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.authenticationCode.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var bookmarkList: [String] {
        get {
            return UserDefaults.standard.array(forKey: Keys.bookmark.rawValue)  as? [String] ?? [String]()
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.bookmark.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
