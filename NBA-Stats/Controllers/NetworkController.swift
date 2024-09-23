//
//  NetworkController.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/7/24.
//  Edited by Deseret Baker on 9/22/24

import Foundation
import CoreData

struct NetworkController {
    private static let baseURL = "https://api.balldontlie.io/v1"
    private static let apiKey = "07315869-8fe7-4d07-a1ae-55976bb4110c"
    
    // Fetch NBA Teams
    static func getTeams() async throws -> [Team] {
        let session = URLSession.shared
        guard let url = URL(string: "\(baseURL)/teams") else {
            throw NetworkErrors.InvalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkErrors.FailedGettingTeams
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[.managedObjectContext] = CoreDataStack.shared.persistentContainer.viewContext
            let result = try decoder.decode(BallDontLieResult<Team>.self, from: data)
            
            // Filter out teams that are not in a division
            return result.data.filter { $0.division?.isEmpty == false }
        } catch {
            throw error
        }
    }
    
    // Fetch Players for a Given Team ID
    static func getPlayers(fromTeamID id: Int) async throws -> [Player] {
        let session = URLSession.shared
        guard let url = URL(string: "\(baseURL)/players?team_ids[]=\(id)") else {
            throw NetworkErrors.InvalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkErrors.FailedGettingPlayers
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[.managedObjectContext] = CoreDataStack.shared.persistentContainer.viewContext
            let result = try decoder.decode(BallDontLieResult<Player>.self, from: data)
            
            return result.data
        } catch {
            throw error
        }
    }

    // Fetch Games for Today
    static func getGamesForToday() async throws -> [Game] {
        let session = URLSession.shared
        
        // Set the URL for fetching games of the current day
        let today = DateFormatter.yyyyMMddFormatter.string(from: Date())
        guard let url = URL(string: "\(baseURL)/games?start_date=\(today)&end_date=\(today)") else {
            throw NetworkErrors.InvalidURL
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkErrors.FailedGettingGames
            }

            // Decode the JSON data to Game objects
            let decoder = JSONDecoder()
            let result = try decoder.decode(BallDontLieResult<Game>.self, from: data)

            return result.data
        } catch {
            throw NetworkErrors.FailedGettingGames
        }
    }
    
    // Unified Network Errors Enum
    enum NetworkErrors: Error {
        case FailedGettingTeams
        case FailedGettingPlayers
        case FailedGettingGames
        case InvalidURL
    }
}

// Extension for DateFormatter to handle "yyyy-MM-dd" format
extension DateFormatter {
    static let yyyyMMddFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
