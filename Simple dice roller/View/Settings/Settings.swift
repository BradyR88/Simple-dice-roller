//
//  Settings.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/3/22.
//

import Foundation

struct Setings {
    private let defaults = UserDefaults.standard
    
    // whether advantage/disadvantage/neutral selector at the bottom of the screen resets to neutral when the user rolls dice
    var resetAdvantage: Bool {
        set {
            defaults.set(newValue, forKey: "resetAdvantage")
        }
        get {
            defaults.bool(forKey: "resetAdvantage")
        }
    }
    // if an event is just a description should it be posted in the event log
    var onlySaveRolls: Bool {
        set {
            defaults.set(newValue, forKey: "discriptinInEvents")
        }
        get {
            defaults.bool(forKey: "discriptinInEvents")
        }
    }
    
    init() {
        // resetAdvantage is true on lonch of the app
        if defaults.value(forKey: "resetAdvantage") == nil {
            defaults.set(true, forKey: "resetAdvantage")
        }
        
        // discriptinInEvents is true on lonch of the app
        if defaults.value(forKey: "discriptinInEvents") == nil {
            defaults.set(true, forKey: "discriptinInEvents")
        }
    }
    
}
