//
//  Event.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

// MARK: Event is anything that can be posted to the timeline from a specific dice roll or another action a creature can take
struct Event: Codable, Identifiable {
    // what creature initial i.e. bugbear
    let id: UUID
    let who: String
    let abilaty: Ability
    let rollResult: RollResult?
    
    // caculated valuse
    var hasDiscription: Bool {
        abilaty.discription != nil
    }
    var hasRollResult: Bool {
        rollResult != nil
    }
    var isDamageRoll: Bool {
        guard let rollResult = rollResult else { return false}
        
        if abilaty.onHit == rollResult.roll {
            return true
        } else {
            return false
        }
    }
    var longName: String {
        var longName = ""
        longName.append(who)
        if abilaty.name != "" {
            longName.append(" - \(abilaty.name)")
        }
        if isDamageRoll {
            longName.append(" - Damage")
        }
        return longName
    }
    
    var longNameInRollReadout: String {
        if longName == "Dice" && hasRollResult {
            return rollResult!.roll.stringName
        } else {
            return longName
        }
    }
    
    var showHitButton: Bool {
        if !isDamageRoll && abilaty.onHit != nil {
            return true
        } else {
            return false
        }
    }
    
    func hitRoll() -> Event {
        // look to see if it was a crit
        var circumstance: Circumstance {
            guard let rollResult = rollResult else {
                return Circumstance.neutral
            }
            guard let roll = abilaty.roll else {
                return Circumstance.neutral
            }
            
            if rollResult.result - roll.toAdd == 20 {
                return Circumstance.crit
            } else {
                return Circumstance.neutral
            }
        }
        
        return Event(who: who, abilaty: abilaty, rollResult: abilaty.onHit?.throwDice(circumstance: circumstance))
    }
    
    init(who: String, abilaty: Ability, rollResult: RollResult?) {
        self.id = UUID()
        self.who = who
        self.abilaty = abilaty
        self.rollResult = rollResult
    }
    
    static let example = Event(who: "Bugbear", abilaty: Ability.example, rollResult: Ability.example.roll!.throwDice())
    static let exampleLong = Event(who: "Bugbear", abilaty: Ability.exampleLong, rollResult: Ability.example.roll!.throwDice())
}
