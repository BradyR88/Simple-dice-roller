//
//  Dice.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

struct Roll: Codable, Identifiable {
    let id: UUID
    let sides: Int
    let facesRolled: [Int]
    let plus: Int
    let total: Int
    let diceRolled: Int
    
    init(sides: Int, faces:[Int], plus: Int) {
        self.id = UUID()
        self.sides = sides
        self.facesRolled = faces
        self.plus = plus
        self.total = facesRolled.sum() + plus
        self.diceRolled = faces.count
    }
}

extension Roll {
    init() {
        self.id = UUID()
        self.sides = 6
        self.facesRolled = [Int.random(in: 1...6)]
        self.plus = 0
        self.total = facesRolled[0]
        self.diceRolled = 1
    }
    
    static let example = Roll()
}
