//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    @Published private(set) var pastRolls: [Roll] = []
    
    init() {
        loadData()
    }
    
    // MARK: loading and saving
    func loadData() {
        do {
            let data = try Data(contentsOf: Constance.savePath)
            pastRolls = try JSONDecoder().decode([Roll].self, from: data)
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
    func rolldice(_ number: Int,d sides: Int,plus: Int) {
        var faces: [Int] = []
        
        for _ in 0..<number {
            faces.append(Int.random(in: 1...sides))
        }
        
        pastRolls.insert(Roll(sides: sides, faces: faces, plus: plus), at: 0)
    }
}
