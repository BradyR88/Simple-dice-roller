//
//  Roll.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/20/22.
//

import Foundation
import SwiftUI

// MARK: Roll - describes what a role is and how to save all the information for the result one
struct Roll: Codable, Equatable {
    // simplest turn of what a roll of the dice can be 1d6 + 1
    var numberOfDice: Int {
        didSet {
            if numberOfDice < 1 {
                numberOfDice = 1
            }
        }
    }
    var numberOfSides: Int
    var toAdd: Int {
        didSet {
            if toAdd < 0 {
                toAdd = 0
            }
        }
    }
    
    // caculated var
    var stringName: String {
        "\(numberOfDice)d\(numberOfSides)\(toAdd > 0 ? " + \(toAdd)" : "")"
    }
    
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
    
    func simpleCustumEvent() -> Event {
        Ability(id: UUID(), name: "", roll: self, onHit: nil, discription: nil).genarateEvent(who: "Dice")
    }
    
    static let example20 = Roll(numberOfDice: 1, numberOfSides: 20, toAdd: 3)
    static let example8 = Roll(numberOfDice: 2, numberOfSides: 8, toAdd: 2)
}

struct RollResult: Codable {
    let roll: Roll
    let faces: [Int]
    let result: Int
    let circumstance: Circumstance
    
    //caculated varibals
    var natTracker: NatTracker {
        if roll.numberOfSides == 20 && result == 20 + roll.toAdd && roll.numberOfDice == 1 {
            return .nat20
        } else if roll.numberOfSides == 20 && result == 1 + roll.toAdd && roll.numberOfDice == 1 {
            return .nat1
        } else {
            return .normal
        }
    }
    var color: Color {
        switch natTracker {
        case .nat1:
            return .red
        case .normal:
            return .primary
        case .nat20:
            return .green
        }
    }
    
    static let example = Roll.example20.throwDice()
    
    enum NatTracker {
        case nat1,normal,nat20
    }
}

enum Circumstance: String, Codable, CaseIterable, Equatable {
case advantage, neutral , disadvantage, crit
}
