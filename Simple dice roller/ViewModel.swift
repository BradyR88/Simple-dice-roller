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
            saveData(to: Constance.savePathPastRolls, from: pastRolls)
        }
    }
    @Published private(set) var rollGroops: [RollGroop] = [] {
        didSet {
            saveData(to: Constance.savePathRollGroops, from: rollGroops)
        }
    }
    @Published var display: RollGroop? = nil
    
    init() {
        loadData(from: Constance.savePathPastRolls, to: &pastRolls)
        loadData(from: Constance.savePathRollGroops, to: &rollGroops)
    }
    
    // MARK: loading and saving
    func loadData<T: Codable>(from url: URL, to: inout [T]) {
        do {
            let data = try Data(contentsOf: url)
            to = try JSONDecoder().decode([T].self, from: data)
        } catch {
            to = []
        }
    }
    
    func saveData<T: Codable>(to url: URL, from: [T]) {
        do {
            let data = try JSONEncoder().encode(from)
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
    
    func togalIsShowing(for rollGroop: RollGroop) {
        // TODO: this function has room to be made vastly more efficient by finding a way to order roll groups and using some sort of binary split search
        let index = rollGroops.firstIndex { $0.id == rollGroop.id }
        guard let index = index else { return }
        rollGroops[index].isShowing.toggle()
        print("rollGroop toggled is now a \(rollGroops[index].isShowing)")
    }
}
