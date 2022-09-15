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
    let subRoll: Bool
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
        
        self.subRoll = false
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
        self.subRoll = false
        self.circumstance = cumstance
    }
    
    init(withSubRollFrom roll: Roll) throws {
        guard let subRoll = roll.subRoll else { throw RollErrors.noSubRoll}
        
        self.id = UUID()
        self.roll = roll
        
        var faces: [Int] = []
        
        for _ in 0..<subRoll.amount {
            faces.append(Int.random(in: 1...subRoll.numberOfSides))
        }
        
        self.subRoll = true
        self.faces = faces.sorted()
        self.total = faces.sum() + subRoll.toAdd
        self.circumstance = .neutral
    }
}

enum Circumstance: String, Codable, CaseIterable, Equatable {
case advantage, neutral , disadvantage
}

enum RollErrors: Error {
    case noSubRoll
}

struct RollGroop: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var rolls: [Roll]
    var isShowing: Bool
    
    static func == (lhs: RollGroop, rhs: RollGroop) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = RollGroop(id: UUID(), name: "Kobold", rolls: [Roll(1, d: 20, toAdd: 4), Roll.exampleWithSubRoll], isShowing: true)
    static let example2 = RollGroop(id: UUID(), name: "Bugbear", rolls: [Roll(1, d: 6, toAdd: 3), Roll(1, d: 20, toAdd: 5), Roll.exampleWithSubRoll], isShowing: true)
}

extension RollGroop {
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.rolls = []
        self.isShowing = false
    }
}


struct Roll: Rollable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var amount: Int 
    var numberOfSides: Int
    var toAdd: Int
    var subRoll: SubRoll?
    
    func critical() -> Roll {
        Roll(amount+amount, d: numberOfSides, toAdd: toAdd)
    }
    
    mutating func regenerateName() {
        name = Constance.diceString(amount, d: numberOfSides, toAdd: toAdd)
    }
    
    static let example = Roll(1, d: 6, toAdd: 4)
    static let exampleWithSubRoll = Roll(name: "test roll", 1, d: 20, toAdd: 5, subRoll: SubRoll(amount: 2, numberOfSides: 6, toAdd: 3))
    
    init(name: String,_ amount: Int, d: Int, toAdd: Int, subRoll: SubRoll?) {
        self.amount = amount
        self.numberOfSides = d
        self.toAdd = toAdd
        self.subRoll = subRoll
        self.name = name
    }
    
    init(_ amount: Int, d: Int, toAdd: Int) {
        self.init(name: Constance.diceString(amount, d: d, toAdd: toAdd), amount, d: d, toAdd: toAdd, subRoll: nil)
    }
    
    init() {
        self.id = UUID()
        self.name = "New Roll"
        self.amount = 1
        self.numberOfSides = 20
        self.toAdd = 0
        self.subRoll = nil
    }
}

struct SubRoll: Rollable, Codable, Identifiable {
    var id = UUID()
    var amount: Int
    var numberOfSides: Int
    var toAdd: Int
}

protocol Rollable {
    var amount: Int { get set }
    var numberOfSides: Int { get set }
    var toAdd: Int { get set }
}
