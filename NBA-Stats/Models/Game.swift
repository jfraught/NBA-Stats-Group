//  Game.swift
//  NBA-Stats
//
//  Created by Deseret Baker on 9/22/24.
//

import Foundation
import CoreData

class Game: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id, date, season, home_team_score, visitor_team_score, home_team, visitor_team, status, college
    }
    
    required convenience init(from decoder: Decoder) throws {
        // Obtain NSManagedObjectContext from decoder's userInfo
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        // Decoding values
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        self.season = try container.decodeIfPresent(Int16.self, forKey: .season) ?? 0
        
        // Decoding nested objects (assuming home_team and visitor_team are represented as team names in JSON)
        self.homeTeam = try container.decodeIfPresent(String.self, forKey: .home_team) ?? "N/A"
        self.visitorTeam = try container.decodeIfPresent(String.self, forKey: .visitor_team) ?? "N/A"
        
        // Decoding scores; provide a default value if scores are absent
        self.homeTeamScore = try container.decodeIfPresent(Int16.self, forKey: .home_team_score) ?? 0
        self.visitorTeamScore = try container.decodeIfPresent(Int16.self, forKey: .visitor_team_score) ?? 0
        
        // Decoding other values
        self.college = try container.decodeIfPresent(String.self, forKey: .college) ?? "Unknown"
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? "Scheduled"
    }
}

