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
        monsters = [Monster.example, Monster.example]
        //pastEvents = []
        loadData(from: Constance.savePathPastRolls, to: &pastEvents)
        #else
        loadData(from: Constance.savePathPastRolls, to: &pastEvents)
        loadData(from: Constance.savePathRollGroops, to: &monsters)
        #endif
    }
    
    // MARK: loading and saving --
    private func loadData<T: Codable>(from url: URL, to: inout [T]) {
        do {
            let data = try Data(contentsOf: url)
            to = try JSONDecoder().decode([T].self, from: data)
        } catch {
            to = []
        }
    }
    private func saveData<T: Codable>(to url: URL, from: [T]) {
        do {
            let data = try JSONEncoder().encode(from)
            try data.write(to: url)
        } catch {
            print("there was an erorr saving the data")
        }
    }
    
    // MARK: user actions -
    
    // content view -------------------------------------------------------------------------
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
        if settings.onlySaveRolls == true {
            if pastEvents[1].hasRollResult == false {
                pastEvents.remove(at: 1)
            }
        }
    }
    
    func tapOnDiscription() {
        if lastEvent!.abilaty.discription!.count >= 80 || descriptionReadMode {
            descriptionReadMode.toggle()
        }
    }
    
    // creation view --------------------------------------------------------------------------
    func addNewMonster() {
        monsters.append(Monster(name: "New Monster", abilaty: [Ability(name: "New Ability")], isShowing: false))
    }
    
    func deleteMonster(at index: Int) {
        monsters.remove(at: index)
    }
    
    func duplicateMonster(at index: Int) {
        var new = monsters[index]
        new.id = UUID()
        new.name = "coppy of \(new.name)"
        
        monsters.append(new)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        indicatedMonster.abilaty.move(fromOffsets: source, toOffset: destination)
    }
    
    func togalIsShowing(for index: Int) {
        // TODO: make safer by checking that the index exist first
        monsters[index].isShowing.toggle()
    }
    
    // edit view --------------------------------------------------------------------------------
    func addNewAbilaty() {
        indicatedMonster.abilaty.append(Ability(name: "New Ability"))
        abilityIndex = indicatedMonster.abilaty.count - 1
    }
    
    func deleteAbility(at offsets: IndexSet) {
        // Store the unique ID of the previous selected roll
        let selectedID = indicatedAbility.id
        // set roll index to nal so it won't accidentally reference an index at no longer exist
        abilityIndex = nil
        // delete selected rolls
        indicatedMonster.abilaty.remove(atOffsets: offsets)
        // look back through the roles and see if the previously selected index is still there if it is re-select it
        for (index, roll) in indicatedMonster.abilaty.enumerated() {
            if roll.id == selectedID {
                monsterIndex = index
                break
            }
        }
    }
    
    func tapOnAbility(at index: Int) {
        abilityIndex = index
    }
    
    // setings view -----------------------------------------------------------------------------
    func deleteAllEvents() {
        pastEvents = []
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
