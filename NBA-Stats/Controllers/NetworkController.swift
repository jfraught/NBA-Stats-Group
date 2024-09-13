//
//  NetworkController.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/7/24.
//

import Foundation
import CoreData

struct NetworkController {
    private static var url = "https://api.balldontlie.io/v1"
    private static var apiKey = "" // Add your API key here
    
    static func getTeams() async throws -> [Team] {
        // Initialize our session and url
        let session = URLSession.shared
        let url = URLComponents(string: "\(url)/teams")!
        
        var request = URLRequest(url: url.url!)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        var data: Data
        var response: URLResponse
        
        do {
            let (httpData, httpResponse) = try await session.data(for: request)
            data = httpData
            response = httpResponse
        } catch {
            throw error
        }
       
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.FailedGettingTeams
        }
        
        // Decode our response data to a usable Team array struct
        let decoder = JSONDecoder()
        decoder.userInfo[.managedObjectContext] = CoreDataStack.shared.persistentContainer.viewContext
        let result = try decoder.decode(BallDontLieResult<Team>.self, from: data)
        
        // Return teams that are in a division
        return result.data.filter { team in
            if let division = team.division {
                return !division.isEmpty
            }
            return false
        }
    }
    
    static func getPlayers(fromTeamID id: Int) async throws -> [Player] {
        // Initialize our session and url
        let session = URLSession.shared
        let url = URLComponents(string: "\(url)/players?team_ids[]=\(id)")!
        
        var request = URLRequest(url: url.url!)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        var data: Data
        var response: URLResponse
        
        do {
            let (httpData, httpResponse) = try await session.data(for: request)
            data = httpData
            response = httpResponse
        } catch {
            throw error
        }
       
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.FailedGettingTeams
        }
        
        // Decode our response data to a usable Player array struct
        let decoder = JSONDecoder()
        decoder.userInfo[.managedObjectContext] = CoreDataStack.shared.persistentContainer.viewContext
        let result = try decoder.decode(BallDontLieResult<Player>.self, from: data)
        
        return result.data
    }
    
    private enum NetworkErrors: Error {
        case FailedGettingTeams
    }
}
