//  Game.swift
//  NBA-Stats
//
//  Created by Deseret Baker on 9/22/24.
//

//import Foundation
//import CoreData
//
//class Game: NSManagedObject, Decodable {
//    enum CodingKeys: CodingKey {
//        case id, date, season, home_team_score, visitor_team_score, home_team, visitor_team
//    }
//    
//    required convenience init(from decoder: Decoder) throws {
//        // Obtain NSManagedObjectContext from decoder's userInfo
//        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
//            throw DecoderConfigurationError.missingManagedObjectContext
//        }
//        
//        let entity = NSEntityDescription.entity(forEntityName: "Game", in: context)!
//        
////        self.init(context: context)
//        self.init(entity: entity, insertInto: context)
//        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int16.self, forKey: .id)
//        self.date = try container.decode(String.self, forKey: .date)
//        self.season = try container.decode(Int16.self, forKey: .season)
//        self.homeTeam = try container.decode(String.self, forKey: .home_team)
//        self.visitorTeam = try container.decode(String.self, forKey: .visitor_team)
//        self.homeTeamScore = try container.decode(Int16.self, forKey: .home_team_score)
//        self.visitorTeamScore = try container.decode(Int16.self, forKey: .visitor_team_score)
//    }
//}
//
//extension Game {
//    
//    static let mockGames = [
//
//        (id: 1, date: "2024-01-01", season: 2024, homeTeam: "Mock Team 1", visitorTeam: "Mock Team 2", homeTeamScore: 10, visitorTeamScore: 20), // past
//        (id: 2, date: "2024-01-02", season: 2024, homeTeam: "Mock Team 3", visitorTeam: "Mock Team 4", homeTeamScore: 30, visitorTeamScore: 40), // past
//        (id: 3, date: "2024-01-03", season: 2024, homeTeam: "Mock Team 5", visitorTeam: "Mock Team 6", homeTeamScore: 50, visitorTeamScore: 60), // past
//        (id: 4, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 7", visitorTeam: "Mock Team 8", homeTeamScore: 70, visitorTeamScore: 80), // today
//        (id: 5, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 9", visitorTeam: "Mock Team 10", homeTeamScore: 90, visitorTeamScore: 100), // today
//        (id: 6, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 11", visitorTeam: "Mock Team 12", homeTeamScore: 110, visitorTeamScore: 120), // today
//        (id: 7, date: "2024-12-01", season: 2024, homeTeam: "Mock Team 13", visitorTeam: "Mock Team 14", homeTeamScore: 130, visitorTeamScore: 140), // future
//        (id: 8, date: "2024-12-25", season: 2024, homeTeam: "Mock Team 15", visitorTeam: "Mock Team 16", homeTeamScore: 150, visitorTeamScore: 160), // future
//        (id: 9, date: "2024-12-29", season: 2024, homeTeam: "Mock Team 17", visitorTeam: "Mock Team 18", homeTeamScore: 170, visitorTeamScore: 180) // future
//        
//        // note: Team scores are the team number * 10 just to make sure the team score matches the team for debugging issues
//    ]
//    
//}

import Foundation
import CoreData

class Game: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, date, season, home_team_score, visitor_team_score, home_team, visitor_team
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.season = try container.decode(Int16.self, forKey: .season)
        self.homeTeam = try container.decode(String.self, forKey: .home_team)
        self.visitorTeam = try container.decode(String.self, forKey: .visitor_team)
        self.homeTeamScore = try container.decode(Int16.self, forKey: .home_team_score)
        self.visitorTeamScore = try container.decode(Int16.self, forKey: .visitor_team_score)
    }
}

extension Game {
    
    static func mockGames(in context: NSManagedObjectContext) -> [Game] {
        let mockData = [
            (id: 1, date: "2024-01-01", season: 2024, homeTeam: "Mock Team 1", visitorTeam: "Mock Team 2", homeTeamScore: 10, visitorTeamScore: 20),
            (id: 2, date: "2024-01-02", season: 2024, homeTeam: "Mock Team 3", visitorTeam: "Mock Team 4", homeTeamScore: 30, visitorTeamScore: 40),
            (id: 3, date: "2024-01-03", season: 2024, homeTeam: "Mock Team 5", visitorTeam: "Mock Team 6", homeTeamScore: 50, visitorTeamScore: 60),
            (id: 4, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 7", visitorTeam: "Mock Team 8", homeTeamScore: 70, visitorTeamScore: 80),
            (id: 5, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 9", visitorTeam: "Mock Team 10", homeTeamScore: 90, visitorTeamScore: 100),
            (id: 6, date: "2024-10-10", season: 2024, homeTeam: "Mock Team 11", visitorTeam: "Mock Team 12", homeTeamScore: 110, visitorTeamScore: 120),
            (id: 7, date: "2024-12-01", season: 2024, homeTeam: "Mock Team 13", visitorTeam: "Mock Team 14", homeTeamScore: 130, visitorTeamScore: 140),
            (id: 8, date: "2024-12-25", season: 2024, homeTeam: "Mock Team 15", visitorTeam: "Mock Team 16", homeTeamScore: 150, visitorTeamScore: 160),
            (id: 9, date: "2024-12-29", season: 2024, homeTeam: "Mock Team 17", visitorTeam: "Mock Team 18", homeTeamScore: 170, visitorTeamScore: 180)
        ]
        
        let games = mockData.map { data in
            
            let game = Game(context: context)
            game.id = Int16(data.id)
            game.date = data.date
            game.season = Int16(data.season)
            game.homeTeam = data.homeTeam
            game.visitorTeam = data.visitorTeam
            game.homeTeamScore = Int16(data.homeTeamScore)
            game.visitorTeamScore = Int16(data.visitorTeamScore)
            
            return game
        }
        try? context.save()
        return games
    }
}
