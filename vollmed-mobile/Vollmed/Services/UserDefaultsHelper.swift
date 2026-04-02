//
//  Untitled.swift
//  Vollmed
//
//  Created by Rafael Lima on 02/04/26.
//

import Foundation

enum UserDefaultsKeys: String {
    case id, token
}

struct UserDefaultsHelper {
    static func save(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
