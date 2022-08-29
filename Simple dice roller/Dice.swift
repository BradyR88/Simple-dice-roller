//
//  Dice.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

struct RollResult: Codable, Identifiable {
    let id: UUID
    let roll: Roll
    let faces: [Int]
    let total: Int
    
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
    }
}

class Roll: Codable {
    let amount: Int
    let numberOfSides: Int
    let toAdd: Int
    
    let subRoll: Roll?
        
    static let example = Roll(1, d: 6, toAdd: 4)
    
    init(_ amount: Int, d: Int, toAdd: Int, subRoll: Roll?) {
        self.amount = amount
        self.numberOfSides = d
        self.toAdd = toAdd
        self.subRoll = subRoll
    }
    
    convenience init(_ amount: Int, d: Int, toAdd: Int) {
        self.init(amount, d: d, toAdd: toAdd, subRoll: nil)
    }
}
