//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    @Published private(set) var pastRolls: [RollResult] = [] {
        didSet {
            saveData(to: Constance.savePathPastRolls)
        }
    }
    
    init() {
        loadData(from: Constance.savePathPastRolls)
    }
    
    // MARK: loading and saving
    func loadData(from url: URL) {
        do {
            let data = try Data(contentsOf: url)
            pastRolls = try JSONDecoder().decode([RollResult].self, from: data)
        } catch {
            pastRolls = []
        }
    }
    
    func saveData(to url: URL) {
        do {
            let data = try JSONEncoder().encode(pastRolls)
            try data.write(to: url)
        } catch {
            print("there was an erorr saving the data")
        }
    }
    
    // MARK: user actions
    func rolldice(_ roll: Roll) {
        pastRolls.insert(RollResult(roll: roll), at: 0)
    }
    
    func rollWithAdvantage(_ roll: Roll) {
        pastRolls.insert(RollResult(roll: roll, .advantage), at: 0)
    }
    
    func rollWithDisadvantage(_ roll: Roll) {
        pastRolls.insert(RollResult(roll: roll, .disadvantage), at: 0)
    }
}
