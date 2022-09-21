//
//  Event.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

// MARK: Event is anything that can be posted to the timeline from a specific dice roll or another action a creature can take
struct Event: Encodable {
    // what creature initial i.e. bugbear
    let who: String
    let abilaty: Ability
    let damageRoll: Bool
    let rollResult: RollResult?
    
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
        
        return Event(who: who, abilaty: abilaty,damageRoll: true, rollResult: abilaty.onHit?.throwDice(circumstance: circumstance))
    }
}
