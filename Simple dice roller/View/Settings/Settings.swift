//
//  Settings.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/3/22.
//

import Foundation

struct Setings {
    private let defaults = UserDefaults.standard
    
    var resetAdvantage: Bool {
        set {
            defaults.set(newValue, forKey: "resetAdvantage")
        }
        get {
            defaults.bool(forKey: "resetAdvantage")
        }
    }
    
    init() {
        if defaults.value(forKey: "resetAdvantage") == nil {
            defaults.set(true, forKey: "resetAdvantage")
        }
    }
    
}
