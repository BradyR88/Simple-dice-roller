//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    @Published private(set) var pastRolls: [Event] = [] {
        didSet {
            // stop the list from growing over 100 long
            let over = pastRolls.count - 100
            if over >= 1 {
                pastRolls.removeLast(over)
            }
            // save
            saveData(to: Constance.savePathPastRolls, from: pastRolls)
        }
    }
    var lastRoll: Event? {
        pastRolls.first
    }
    var pastRollsDropFirst: [Event] {
        if pastRolls.count == 1 {
            return []
        }
        
        var new = pastRolls
        if new.count > 1 {
            new.remove(at: 0)
        }
        return new
    }
    
    @Published private(set) var rollGroops: [Monster] = [] {
        didSet {
            saveData(to: Constance.savePathRollGroops, from: rollGroops)
        }
    }
    @Published var display: Monster? = nil
    
    var rollGroopIndex: Int? = nil
    @Published var rollIndex: Int? = nil
    
    var indicatedRollGroop: Monster {
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
            let error = Roll(name: "Error",from: nil, 1, d: 20, toAdd: 0, subRoll: nil)
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
    
    // MARK: init ---------------------------------------------------
    init() {
        loadData(from: Constance.savePathPastRolls, to: &pastRolls)
        loadData(from: Constance.savePathRollGroops, to: &rollGroops)
        //rollGroops = [RollGroop.example, RollGroop.example2]
        //pastRolls = []
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
    
}
