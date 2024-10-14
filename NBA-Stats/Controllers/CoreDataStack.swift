//
//  CoreDataStack.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/7/24.
//

import Foundation
import CoreData

// Define an observable class to encapsulate all Core Data-related functionality.
class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "NBA_Stats")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}

extension CoreDataStack {
    // Add a convenience method to commit changes to the store.
    func save() {
        // Verify that the context has uncommitted changes.
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            // Attempt to save changes.
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    func getTeams() throws -> [Team]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        let result = try persistentContainer.viewContext.fetch(fetchRequest)
        return result as? [Team]
    }
    
    func getGames() throws -> [Game]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let result = try persistentContainer.viewContext.fetch(fetchRequest)
        return result as? [Game]
    }
    
    func saveGames(games: [Game]) throws {
        // Assuming there are no games in core data.
        // If you want to refresh the games you should delete the teams in core data first and then save.
        
        for game in games {
            let newGame = NSEntityDescription.insertNewObject(forEntityName: "Game", into: persistentContainer.viewContext)
            newGame.setValue(game.id, forKey: "id")
            newGame.setValue(game.date, forKey: "date")
            newGame.setValue(game.season, forKey: "season")
            newGame.setValue(game.homeTeamScore, forKey: "home_team_score")
            newGame.setValue(game.visitorTeamScore, forKey: "visitor_team_score")
            newGame.setValue(game.homeTeam, forKey: "home_team")
            newGame.setValue(game.visitorTeam, forKey: "visitor_team")
        }
        
        save()
    }
    
    func getGames(matching predicate: NSPredicate) throws -> [Game] {
        let fetchRequest = Game.fetchRequest()
        fetchRequest.predicate = predicate
        return try persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    func saveTeams(teams: [Team]) throws {
        // Assuming there are no teams in core data.
        // If you want to refresh the teams you should delete the teams in core data first and then save.
        
        for team in teams {
            let newTeam = NSEntityDescription.insertNewObject(forEntityName: "Team", into: persistentContainer.viewContext)
            newTeam.setValue(team.id, forKey: "id")
            newTeam.setValue(team.conference, forKey: "conference")
            newTeam.setValue(team.division, forKey: "division")
            newTeam.setValue(team.city, forKey: "city")
            newTeam.setValue(team.name, forKey: "name")
            newTeam.setValue(team.full_name, forKey: "full_name")
            newTeam.setValue(team.abbreviation, forKey: "abbreviation")
        }
        
        save()
    }
    
    func saveNewPlayer(player: Player, for team: Team) {
        let newPlayer = Player(context: persistentContainer.viewContext)
        
        newPlayer.id = player.id
        newPlayer.first_name = player.first_name
        newPlayer.last_name = player.last_name
        newPlayer.college = player.college
        newPlayer.country = player.country
        newPlayer.draft_number = player.draft_number
        newPlayer.draft_round = player.draft_round
        newPlayer.draft_year = player.draft_year
        newPlayer.height = player.height
        newPlayer.jersey_number = player.jersey_number
        newPlayer.position = player.position
        newPlayer.weight = player.weight
        newPlayer.team = team
        
        save()
    }
    
    func getPlayers(matching predicate: NSPredicate) throws -> [Player] {
        let fetchRequest = Player.fetchRequest()
        fetchRequest.predicate = predicate
        return try persistentContainer.viewContext.fetch(fetchRequest)
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
