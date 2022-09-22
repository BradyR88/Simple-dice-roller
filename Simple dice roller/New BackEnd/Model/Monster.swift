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
    
    static let example = Monster(name: "", abilaty: [Ability.example], isShowing: true)
}

// MARK: abilities - anything a monster can do whether that includes dice rolls or not
struct Ability: Codable, Identifiable {
    var id = UUID()
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
    
    static let example = Ability(id: UUID(), name: "Club", roll: Roll.example20, onHit: Roll.example8, discription: "DC12 strength saving or be knocked pron")
}
