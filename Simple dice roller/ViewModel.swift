//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

//@MainActor class ViewModel: ObservableObject {
//    @Published private(set) var pastRolls: [RollResult] = [] {
//        didSet {
//            // stop the list from growing over 100 long
//            let over = pastRolls.count - 100
//            if over >= 1 {
//                pastRolls.removeLast(over)
//            }
//            // save
//            saveData(to: Constance.savePathPastRolls, from: pastRolls)
//        }
//    }
//    var lastRoll: RollResult? {
//        pastRolls.first
//    }
//    var pastRollsDropFirst: [RollResult] {
//        if pastRolls.count == 1 {
//            return []
//        }
//        
//        var new = pastRolls
//        if new.count > 1 {
//            new.remove(at: 0)
//        }
//        return new
//    }
//    
//    @Published private(set) var rollGroops: [RollGroop] = [] {
//        didSet {
//            saveData(to: Constance.savePathRollGroops, from: rollGroops)
//        }
//    }
//    @Published var display: RollGroop? = nil
//    
//    var rollGroopIndex: Int? = nil
//    @Published var rollIndex: Int? = nil
//    
//    var indicatedRollGroop: RollGroop {
//        get {
//            guard let rollGroopIndex = rollGroopIndex else {
//                return RollGroop(name: "Error")
//            }
//            // TODO: make safer by checking that the index exist first
//            return rollGroops[rollGroopIndex]
//        }
//        set {
//            guard let rollGroopIndex = rollGroopIndex else { return }
//            // TODO: make safer by checking that the index exist first
//            rollGroops[rollGroopIndex] = newValue
//        }
//    }
//    
//    var indicatedRoll: Roll {
//        get {
//            let error = Roll(name: "Error",from: nil, 1, d: 20, toAdd: 0, subRoll: nil)
//            guard let rollGroopIndex = rollGroopIndex else {
//                return error
//            }
//            guard let rollIndex = rollIndex else {
//                return error
//            }
//            
//            return rollGroops[rollGroopIndex].rolls[rollIndex]
//        }
//        set {
//            guard let rollGroopIndex = rollGroopIndex else { return }
//            guard let rollIndex = rollIndex else { return }
//            
//            rollGroops[rollGroopIndex].rolls[rollIndex] = newValue
//        }
//    }
//    
//    var indicatedSubRoll: SubRoll {
//        get {
//            indicatedRoll.subRoll ?? SubRoll(amount: 1, numberOfSides: 8, toAdd: 0)
//        }
//        set {
//            guard let rollGroopIndex = rollGroopIndex else { return }
//            guard let rollIndex = rollIndex else { return }
//            
//            rollGroops[rollGroopIndex].rolls[rollIndex].subRoll = newValue
//        }
//    }
//    
//    // MARK: init ---------------------------------------------------
//    init() {
//        loadData(from: Constance.savePathPastRolls, to: &pastRolls)
//        loadData(from: Constance.savePathRollGroops, to: &rollGroops)
//        //rollGroops = [RollGroop.example, RollGroop.example2]
//        //pastRolls = []
//    }
//    
//    // MARK: loading and saving
//    func loadData<T: Codable>(from url: URL, to: inout [T]) {
//        do {
//            let data = try Data(contentsOf: url)
//            to = try JSONDecoder().decode([T].self, from: data)
//        } catch {
//            to = []
//        }
//    }
//    
//    func saveData<T: Codable>(to url: URL, from: [T]) {
//        do {
//            let data = try JSONEncoder().encode(from)
//            try data.write(to: url)
//        } catch {
//            print("there was an erorr saving the data")
//        }
//    }
//    
//    // MARK: user actions
//    func rolldice(_ roll: Roll, with circumstance: Circumstance?) {
//        switch circumstance {
//        case .advantage:
//            pastRolls.insert(RollResult(roll: roll, .advantage), at: 0)
//        case .disadvantage:
//            pastRolls.insert(RollResult(roll: roll, .disadvantage), at: 0)
//        case .neutral, .none, .crit:
//            pastRolls.insert(RollResult(roll: roll), at: 0)
//        }
//    }
//    
//    func subRoll(from roll: Roll, isCrit: Bool = false) {
//        do {
//            pastRolls.insert(try RollResult(withSubRollFrom: roll, isCrit: isCrit), at: 0)
//        }
//        catch {
//            print("The roll provided did not have a sub roll")
//        }
//        
//    }
//    
//    func rollHit(from rollResult: RollResult) {
//        guard rollResult.roll.numberOfSides == 20 else {
//            subRoll(from: rollResult.roll)
//            return
//        }
//        
//        if rollResult.total - rollResult.roll.toAdd == 20 {
//            // was a crit
//            subRoll(from: rollResult.roll, isCrit: true)
//        } else {
//            subRoll(from: rollResult.roll)
//        }
//    }
//    
//    func togalIsShowing(for index: Int) {
//        // TODO: make safer by checking that the index exist first
//        rollGroops[index].isShowing.toggle()
//    }
//    
//    func deleteRoll(at offsets: IndexSet) {
//        // Store the unique ID of the previous selected roll
//        let selectedID = indicatedRoll.id
//        // set roll index to nal so it won't accidentally reference an index at no longer exist
//        rollIndex = nil
//        // delete selected rolls
//        indicatedRollGroop.rolls.remove(atOffsets: offsets)
//        // look back through the roles and see if the previously selected index is still there if it is re-select it
//        for (index, roll) in indicatedRollGroop.rolls.enumerated() {
//            if roll.id == selectedID {
//                rollIndex = index
//                break
//            }
//        }
//    }
//    
//    func deleteRollGroop(at index: Int) {
//        rollGroops.remove(at: index)
//    }
//    
//    func tapOnRoll(at index: Int) {
//        if index == rollIndex {
//            rollIndex = nil
//        } else {
//            rollIndex = index
//        }
//    }
//    
//    func addNewRollGroop() {
//        rollGroops.append(RollGroop(name: "New Groop"))
//    }
//    
//    func addNewRoll() {
//        indicatedRollGroop.rolls.append(Roll(from: indicatedRollGroop.name))
//        rollIndex = indicatedRollGroop.rolls.count - 1
//    }
//    
//    func removeSubRoll() {
//        indicatedRoll.subRoll = nil
//    }
//    
//    // MARK: background view management functions
//    func resetAllIndexes() {
//        rollIndex = nil
//        rollGroopIndex = nil
//    }
//    
//    func updateDisplay() {
//        // look to see the previous selected role group is still visible or if it has been removed by the user and needs to be set back to nil
//        var mach = false
//        for rollGroop in rollGroops {
//            if rollGroop == display {
//                mach = rollGroop.isShowing
//                break
//            }
//        }
//        if !mach {
//            display = nil
//        }
//    }
//}
