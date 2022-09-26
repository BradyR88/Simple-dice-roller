//
//  Monster.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

// MARK: Monster
struct Monster: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String
    var abilaty: [Ability]
    var isShowing: Bool
    
    static func == (lhs: Monster, rhs: Monster) -> Bool { lhs.id == rhs.id }
    
    static let example = Monster(name: "BugBear", abilaty: [Ability.example], isShowing: true)
}

// MARK: abilities - anything a monster can do whether that includes dice rolls or not
struct Ability: Codable, Identifiable {
    var id = UUID()
    var name: String
    var roll: Roll?
    var onHit: Roll?
    var discription: String?
    
    // calculate variable
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
}
