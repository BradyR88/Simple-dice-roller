//
//  Monster.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

// MARK: Monster
struct Monster: Codable, Comparable, Equatable, Identifiable {
    
    
    var id = UUID()
    var name: String
    var abilaty: [Ability]
    var isShowing: Bool
    
    static func == (lhs: Monster, rhs: Monster) -> Bool { lhs.id == rhs.id }
    static func < (lhs: Monster, rhs: Monster) -> Bool { lhs.name < rhs.name }
    
    static let example = Monster(name: "Bugbear",
                                 abilaty: [
                                    Ability(id: UUID(), name: "Brute", roll: nil, onHit: nil, discription: " A melee weapon deals one extra die of its damage when the bugbear hits with it (included in the attack)."),
                                    Ability(id: UUID(), name: "Surprise Attack", roll: nil, onHit: Roll(numberOfDice: 2, numberOfSides: 6, toAdd: 0), discription: "If the bugbear surprises a creature and hits it with an attack during the first round of combat, the target takes an extra 7 (2d6) damage from the attack."),
                                    Ability(id: UUID(), name: "Morningstar", roll: Roll(numberOfDice: 1, numberOfSides: 20, toAdd: 2), onHit: Roll(numberOfDice: 2, numberOfSides: 8, toAdd: 2), discription: nil),
                                    Ability(id: UUID(), name: "Javelin", roll: Roll(numberOfDice: 1, numberOfSides: 20, toAdd: 4), onHit: Roll(numberOfDice: 2, numberOfSides: 6, toAdd: 2), discription: nil) ],
                                 isShowing: true)

}

// MARK: abilities - anything a monster can do whether that includes dice rolls or not
struct Ability: Codable, Identifiable {
    var id = UUID()
    var name: String
    var roll: Roll?
    var onHit: Roll?
    var discription: String?
    
    // calculate variable
    var hasRoll: Bool {
        get {
            if roll != nil {
                return true
            } else {
                return false
            }
        }
        set {
            if newValue == false {
                roll = nil
            } else {
                roll = Roll(numberOfDice: 1, numberOfSides: 20, toAdd: 0)
            }
        }
    }
    
    var hasOnHit: Bool {
        get {
            if onHit != nil {
                return true
            } else {
                return false
            }
        }
        set {
            if newValue == false {
                onHit = nil
            } else {
                onHit = Roll(numberOfDice: 1, numberOfSides: 8, toAdd: 0)
            }
        }
    }
    
    var longName: String {
        var longName = name
        if roll != nil {
            longName.append(" - \(Constance.diceStringPlus(roll: roll!))")
        }
        if discription != nil {
            longName.append(" - 📄")
        }
        return longName
    }
    
    var safeDiscription: String {
        get {
            if discription == nil {
                return ""
            } else {
                return discription!
            }
        }
        set {
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                discription = nil
            } else {
                discription = newValue
            }
        }
    }
    
    func genarateEvent(who: String, circumstance: Circumstance = .neutral, damageRoll: Bool = false) -> Event {
        var rollResult: RollResult? {
            if damageRoll {
                return onHit?.throwDice(circumstance: circumstance)
            } else {
                return roll?.throwDice(circumstance: circumstance)
            }
        }
        
        return Event(who: who, abilaty: self, rollResult: rollResult)
    }
    
    static let example = Ability(id: UUID(), name: "Club", roll: Roll.example20, onHit: Roll.example8, discription: "DC12 strength saving or be knocked pron")
    static let exampleLong = Ability(id: UUID(), name: "Club", roll: Roll.example20, onHit: Roll.example8, discription: "DC12 strength saving or be knocked pron Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
}
