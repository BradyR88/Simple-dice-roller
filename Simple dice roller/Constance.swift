//
//  Constance.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

struct Constance {
    static let savePathPastRolls = FileManager.documentsDirectory.appendingPathComponent("pastRolls")
    static let savePathRollGroops = FileManager.documentsDirectory.appendingPathComponent("rollGroops")
    
    static func diceString(_ amount: Int, d numberOfSides: Int, toAdd: Int) -> String {
        "\(amount)d\(numberOfSides)\(toAdd > 0 ? " + \(toAdd)" : "")"
    }
    
    static func diceStringPlus<T: Rollable>(roll: T) -> String {
        "\(roll.amount)d\(roll.numberOfSides)\(roll.toAdd > 0 ? " + \(roll.toAdd)" : "")"
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
