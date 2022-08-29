//
//  Constance.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

struct Constance {
    static let savePathPastRolls = FileManager.documentsDirectory.appendingPathComponent("pastRolls")
    static let savePathRollList = FileManager.documentsDirectory.appendingPathComponent("rollList")
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
