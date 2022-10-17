//
//  ViewModel.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/21/22.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    // MARK: retrieved from save -
    @Published private(set) var pastEvents: [Event] = [] {
        didSet {
            // stop the list from growing over 100 long
            let over = pastEvents.count - 100
            if over >= 1 {
                pastEvents.removeLast(over)
            }
            // save
            saveData(to: Constance.savePathPastRolls, from: pastEvents)
        }
    }
    @Published private(set) var monsters: [Monster] = [] {
        didSet {
            saveData(to: Constance.savePathRollGroops, from: monsters)
        }
    }
    
    // MARK: navigating view data -
    
    // separates out the last event so it can be displayed more prominently
    var lastEvent: Event? {
        pastEvents.first
    }
    var pastEventsDropFirst: [Event] {
        if pastEvents.count == 1 {
            return []
        }
        
        var new = pastEvents
        if new.count > 1 {
            new.remove(at: 0)
        }
        return new
    }
    
    // heads or put the description text into long read mode
    @Published var descriptionReadMode: Bool = false
    
    // what Monster they currently have selected to understand what abilities to display in the ContentView
    @Published var display: Monster? = nil
    @Published var circumstance: Circumstance = .neutral
    
    // what is the index of the monster and ability in order to keep user edits tied to the monster
    @Published var monsterIndex: Int? = nil
    @Published var abilityIndex: Int? = nil
    
    // sorted list of monster to allow for filtering and organization by user
    var sortedMonsters: [Monster] {
        get {
            let sorted: [Monster]
            
            if sortMonsterText.isEmpty {
                sorted = monsters
            } else {
                sorted = monsters.filter { $0.name.contains(sortMonsterText) }
            }
            
            return sorted.sorted()
        }
    }
    @Published var sortMonsterText: String = ""
    
    // uses the index to return the specific monster or ability the user is interacting with anti-any changes they make back to the master list
    var indicatedMonster: Monster {
        get {
            guard let monsterIndex = monsterIndex else {
                return Monster(name: "Error", abilaty: [], isShowing: false)
            }
            // TODO: make safer by checking that the index exist first
            return monsters[monsterIndex]
        }
        set {
            guard let monsterIndex = monsterIndex else { return }
            // TODO: make safer by checking that the index exist first
            monsters[monsterIndex] = newValue
        }
    }
    var indicatedAbility: Ability {
        get {
            let error = Ability(name: "Erorr")
            guard let monsterIndex = monsterIndex else { return error }
            guard let abilityIndex = abilityIndex else { return error }
            
            return monsters[monsterIndex].abilaty[abilityIndex]
        }
        set {
            guard let monsterIndex = monsterIndex else { return }
            guard let abilityIndex = abilityIndex else { return }
            
            monsters[monsterIndex].abilaty[abilityIndex] = newValue
        }
    }
    
    // MARK: settings
    @Published var settings = Setings()
    
    // MARK: init -
    init() {
        #if targetEnvironment(simulator)
        monsters = [Monster.example]
        //pastEvents = []
        loadData(from: Constance.savePathPastRolls, to: &pastEvents)
        #else
        loadData(from: Constance.savePathPastRolls, to: &pastEvents)
        loadData(from: Constance.savePathRollGroops, to: &monsters)
        
        // Single sort on launch to make certain operations in the application complete quicker
        monsters.sort()
        #endif
        
        if monsters.isEmpty {
            // provide example Monster
            monsters.append(Monster.example)
        }
    }
    
    // MARK: loading and saving --
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
    
    // MARK: user actions -
    
    func addNewAbilaty() {
        indicatedMonster.abilaty.append(Ability(name: "New Ability"))
        // is this still neaded ? 
        abilityIndex = indicatedMonster.abilaty.count - 1
    }
    
    func addNewRollGroop() {
        monsters.append(Monster(name: "New Monster", abilaty: [Ability(name: "New Ability")], isShowing: false))
        monsterIndex = monsters.count - 1
    }
    
    func addToEvent(_ event: Event?) {
        // stops a Visual bug from occurring
        descriptionReadMode = false
        
        // inserts if it has one
        guard let event = event else { return }
        pastEvents.insert(event, at: 0)
        
        // handled user preferences from settings
        if settings.resetAdvantage {
            circumstance = .neutral
        }
        if settings.onlySaveRolls == false {
            guard pastEvents.count > 2 else { return }
            if pastEvents[1].hasRollResult == false {
                pastEvents.remove(at: 1)
            }
        }
    }
    
    func deleteAllEvents() {
        pastEvents = []
    }
    
    func deleteMonster(_ monster: Monster) {
        indexMatch(monster) { index in
            monsters.remove(at: index)
        }
    }
    func deleteMonster(at indexSet: IndexSet) {
        if let index = indexSet.first {
            indexMatch(sortedMonsters[index]) { index in
                monsters.remove(at: index)
            }
        }
    }
    
    func deleteAbilaty(at offsets: IndexSet) {
        indicatedMonster.abilaty.remove(atOffsets: offsets)
    }
    
    func duplicateMonster(_ monster: Monster) {
        var new = monster
        new.id = UUID()
        new.isShowing = false
        new.name = "coppy of \(new.name)"
        
        monsters.append(new)
        
        monsterIndex = monsters.count - 1
    }
    
    func move(from source: IndexSet, to destination: Int) {
        indicatedMonster.abilaty.move(fromOffsets: source, toOffset: destination)
    }
    
    func setMonsterIndex(to monster: Monster) {
        indexMatch(monster) { index in monsterIndex = index }
    }
    
    func tapOnAbility(at index: Int) {
        abilityIndex = index
    }
    
    func tapOnDiscription() {
        if lastEvent!.abilaty.discription!.count >= 80 || descriptionReadMode {
            descriptionReadMode.toggle()
        }
    }
    
    func togalIsShowing(for monster: Monster) {
        indexMatch(monster) { index in
            monsters[index].isShowing.toggle()
        }
    }
    
    // private funtions ----
    private func indexMatch(_ lookUp: Monster, action: (Int)->Void ) {
        for (index, monster) in monsters.enumerated() {
            if monster == lookUp {
                action(index)
                break
            }
        }
    }
    
    // MARK: background view management functions
    func resetAllIndexes() {
        abilityIndex = nil
        monsterIndex = nil
    }
    
    func updateDisplay() {
        // look to see the previous selected role group is still visible or if it has been removed by the user and needs to be set back to nil
        var match = false
        for monster in monsters {
            if monster == display {
                // monster only check to see if UUID is the same so if any variables inside have been changed by the user it needs to be updated to the new version
                display = monster
                
                match = monster.isShowing
                break
            }
        }
        if !match {
            display = nil
        }
    }
}
