//
//  Roll.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/20/22.
//

import Foundation

struct Event {
    // an Event is anything that can be posted to the timeline from a specific dice roll or another action a creature can take
    // what creature initial i.e. bugbear
    let from: String
    // what did they actually roll i.e. club
    let with: String
    // what was the roll
    let rollResult: RollResult?
    let toHit: Roll?
    let description: String?
    
}
// MARK: Monster
struct Monster {
    var name: String
    var abilaty: [Ability]
}

// MARK: Roll - describes what a role is and how to save all the information for the result one
struct Roll {
    // simplest turn of what a roll of the dice can be 1d6 + 1
    var numberOfDice: Int
    var numberOfSides: Int
    var toAdd: Int
    
    func throwDice(circumstance: Circumstance = .neutral) -> RollResult {
        var result: Int
        var faces:[Int] = []
        var secondFaces: [Int] = []
        
        for _ in 0..<numberOfDice {
            faces.append(Int.random(in: 1...numberOfSides))
            secondFaces.append(Int.random(in: 1...numberOfSides))
        }
        
        switch circumstance {
        case .advantage:
            if faces.sum() > secondFaces.sum() {
                result = faces.sum() + toAdd
            } else {
                result = secondFaces.sum() + toAdd
            }
            faces = faces.sorted() + secondFaces.sorted()
        case .disadvantage:
            if faces.sum() > secondFaces.sum() {
                result = secondFaces.sum() + toAdd
            } else {
                result = faces.sum() + toAdd
            }
            faces = faces.sorted() + secondFaces.sorted()
        case .neutral:
            result = faces.sum() + toAdd
            faces = faces.sorted()
        case .crit:
            faces.append(contentsOf: secondFaces)
            result = faces.sum() + toAdd
            faces = faces.sorted()
        }
        
        return RollResult(roll: self, faces: faces, result: result, circumstance: circumstance)
    }
}

struct RollResult {
    let roll: Roll
    let faces: [Int]
    let result: Int
    let circumstance: Circumstance
}

enum Circumstance: String, Codable, CaseIterable, Equatable {
case advantage, neutral , disadvantage, crit
}

// MARK: abilities - anything Amadu whether that includes dice rolls or not

struct Ability {
    var name: String
    var roll: Roll?
    var onHit: Roll?
    var discription: String?
}
