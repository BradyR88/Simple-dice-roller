//
//  Monster.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

// MARK: Monster
struct Monster: Encodable {
    var name: String
    var abilaty: [Ability]
}

// MARK: abilities - anything a monster can do whether that includes dice rolls or not
struct Ability: Encodable {
    var name: String
    var roll: Roll?
    var onHit: Roll?
    var discription: String?
    
    func genarateEvent(who: String, circumstance: Circumstance = .neutral, damageRoll: Bool = false) -> Event {
        var rollResult: RollResult? {
            if damageRoll {
                return onHit?.throwDice(circumstance: circumstance)
            } else {
                return roll?.throwDice(circumstance: circumstance)
            }
        }
        
        return Event(who: who, abilaty: self, damageRoll: damageRoll, rollResult: rollResult)
    }
}
