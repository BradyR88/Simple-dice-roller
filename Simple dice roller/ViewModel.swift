//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    @Published private(set) var pastRolls: [RollResult] = []
    
    init() {
        loadData()
    }
    
    // MARK: loading and saving
    func loadData() {
        do {
            let data = try Data(contentsOf: Constance.savePath)
            pastRolls = try JSONDecoder().decode([RollResult].self, from: data)
        } catch {
            pastRolls = []
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(pastRolls)
            try data.write(to: Constance.savePath)
        } catch {
            print("there was an erorr saving the data")
        }
    }
    
    // MARK: user actions
    func rolldice(_ roll: Roll) {
        pastRolls.insert(RollResult(roll: roll), at: 0)
    }
}
