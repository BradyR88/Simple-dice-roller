//
//  Dice.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation
import SwiftUI

struct RollResult: Codable, Identifiable {
    let id: UUID
    let roll: Roll
    let faces: [Int]
    let total: Int
    let circumstance: Circumstance
    
    static let example = RollResult(roll: Roll.example)
    
    init(roll: Roll) {
        self.id = UUID()
        self.roll = roll
        
        var faces: [Int] = []
        
        for _ in 0..<roll.amount {
            faces.append(Int.random(in: 1...roll.numberOfSides))
        }
        
        self.faces = faces.sorted()
        self.total = faces.sum() + roll.toAdd
        self.circumstance = .neutral
    }
    
    // initializing method for if I want to define the role being at advantage or not
    // simply find the result for the role twice and picks the higher
    // still list all the roles in the faces category even the ones that were not counted
    init(roll: Roll,_ cumstance: Circumstance) {
        self.id = UUID()
        self.roll = roll
        
        var faces: [Int] = []
        var secondFaces: [Int] = []
        
        for _ in 0..<roll.amount {
            faces.append(Int.random(in: 1...roll.numberOfSides))
            secondFaces.append(Int.random(in: 1...roll.numberOfSides))
        }
        
        switch cumstance {
        case .advantage:
            if faces.sum() > secondFaces.sum() {
                self.total = faces.sum() + roll.toAdd
            } else {
                self.total = secondFaces.sum() + roll.toAdd
            }
            self.faces = faces.sorted() + secondFaces.sorted()
        case .disadvantage:
            if faces.sum() > secondFaces.sum() {
                self.total = secondFaces.sum() + roll.toAdd
            } else {
                self.total = faces.sum() + roll.toAdd
            }
            self.faces = faces.sorted() + secondFaces.sorted()
        case .neutral:
            self.total = faces.sum() + roll.toAdd
            self.faces = faces.sorted()
        }
        self.circumstance = cumstance
    }
    
    enum Circumstance: String, Codable {
    case advantage, disadvantage, neutral
    }
}

struct RollGroop: Codable, Identifiable {
    let id: UUID
    var name: String
    var rolls: [Roll]
    var isShowing: Bool
    
    static let example = RollGroop(id: UUID(), name: "Kobold", rolls: [Roll(1, d: 4, toAdd: 2), Roll(1, d: 20, toAdd: 4)], isShowing: true)
}

extension RollGroop {
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.rolls = []
        self.isShowing = false
    }
}


class Roll: Codable, Identifiable {
    let name: String
    let amount: Int
    let numberOfSides: Int
    let toAdd: Int
    
    let subRoll: Roll?
    
    func critical() -> Roll {
        Roll(amount+amount, d: numberOfSides, toAdd: toAdd)
    }
    
    static let example = Roll(1, d: 6, toAdd: 4)
    
    init(name: String,_ amount: Int, d: Int, toAdd: Int, subRoll: Roll?) {
        self.amount = amount
        self.numberOfSides = d
        self.toAdd = toAdd
        self.subRoll = subRoll
        self.name = name
    }
    
    convenience init(_ amount: Int, d: Int, toAdd: Int) {
        self.init(name: Constance.diceString(amount, d: d, toAdd: toAdd), amount, d: d, toAdd: toAdd, subRoll: nil)
    }
}
