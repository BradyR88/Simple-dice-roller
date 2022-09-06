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
    
    var rollGroopIndex: Int? = nil
    @Published var rollIndex: Int? = nil
    
    var indicatedRollGroop: RollGroop {
        get {
            guard let rollGroopIndex = rollGroopIndex else {
                return RollGroop(name: "Error")
            }
            // TODO: make safer by checking that the index exist first
            return rollGroops[rollGroopIndex]
        }
        set {
            guard let rollGroopIndex = rollGroopIndex else { return }
            // TODO: make safer by checking that the index exist first
            rollGroops[rollGroopIndex] = newValue
        }
    }
    
    var indicatedRoll: Roll {
        get {
            let error = Roll(name: "Error", 1, d: 20, toAdd: 0, subRoll: nil)
            guard let rollGroopIndex = rollGroopIndex else {
                return error
            }
            guard let rollIndex = rollIndex else {
                return error
            }
            
            return rollGroops[rollGroopIndex].rolls[rollIndex]
        }
        
        set {
            guard let rollGroopIndex = rollGroopIndex else { return }
            guard let rollIndex = rollIndex else { return }
            
            rollGroops[rollGroopIndex].rolls[rollIndex] = newValue
        }
    }
    
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
    
    func togalIsShowing(for index: Int) {
        // TODO: make safer by checking that the index exist first
        rollGroops[index].isShowing.toggle()
    }
    
    // MARK: background view management functions
    
    func resetAllIndexes() {
        rollIndex = nil
        rollGroopIndex = nil
    }
}
