//
//  Roll.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/20/22.
//

import Foundation

// MARK: Roll - describes what a role is and how to save all the information for the result one
struct Roll: Codable {
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
    
    static let example20 = Roll(numberOfDice: 1, numberOfSides: 20, toAdd: 3)
    static let example8 = Roll(numberOfDice: 2, numberOfSides: 8, toAdd: 2)
}

struct RollResult: Codable {
    let roll: Roll
    let faces: [Int]
    let result: Int
    let circumstance: Circumstance
    
    static let example = Roll.example20.throwDice()
}

enum Circumstance: String, Codable, CaseIterable, Equatable {
case advantage, neutral , disadvantage, crit
}
