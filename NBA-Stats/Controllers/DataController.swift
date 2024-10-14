//
//  DataController.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/8/24.
//

import Foundation

struct DataController {
    
    static func getTeams() async throws -> [Team] {
        // First try to fetch teams from core data
        if let teams = try CoreDataStack.shared.getTeams(), !teams.isEmpty {
            return teams
        }
        // We don't have teams stored in core data so make a network request, save, and return
        let teams = try await NetworkController.getTeams()
        
        try CoreDataStack.shared.saveTeams(teams: teams)
        
        return teams
    }
    
    static func getPlayers(from team: Team) async throws -> [Player] {
        // First try to fetch players from core data
        let predicate = NSPredicate(format: "team.id == %d", team.id)
        let players = try CoreDataStack.shared.getPlayers(matching: predicate)
        if !players.isEmpty {
            return players
        }
        
        // No players for the given team in core data so make an API call to retrieve them and save them in core data
        let newPlayers = try await NetworkController.getPlayers(fromTeamID: Int(team.id))
        
        for player in newPlayers {
            CoreDataStack.shared.saveNewPlayer(player: player, for: team)
        }
        
        return newPlayers
    }
    
    static func getGames() async throws -> [Game] {
        // First try to fetch games from core data
        if let games = try CoreDataStack.shared.getGames(), !games.isEmpty {
            print("Fetched games from Core Data: \(games.count)")
            return games
        }

        // No games in Core Data, make a network request, save, and return
        let games = try await NetworkController.getGames()
        try CoreDataStack.shared.saveGames(games: games)
        
        print("Fetched games from network: \(games.count)")
        return games
    }

}
