//  Game.swift
//  NBA-Stats
//
//  Created by Deseret Baker on 9/22/24.
//

import Foundation
import CoreData

class Game: NSManagedObject, Decodable {
    @NSManaged var id: Int16
    @NSManaged var date: String
    @NSManaged var homeTeam: String
    @NSManaged var visitorTeam: String
    @NSManaged var homeTeamScore: String
    @NSManaged var visitorTeamScore: String
    @NSManaged var status: String
    @NSManaged var college: String // Ensure this is defined in your Core Data model if needed.

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case homeTeam = "home_team"
        case visitorTeam = "visitor_team"
        case homeTeamScore = "home_team_score"
        case visitorTeamScore = "visitor_team_score"
        case status = "status"
        case college = "college" // Include this if you want to decode the 'college' property
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.homeTeam = try container.decode(String.self, forKey: .homeTeam)
        self.visitorTeam = try container.decode(String.self, forKey: .visitorTeam)
        
        do {
            self.homeTeamScore = try container.decode(String.self, forKey: .homeTeamScore)
            self.visitorTeamScore = try container.decode(String.self, forKey: .visitorTeamScore)
            self.college = try container.decode(String.self, forKey: .college) // This needs to be part of your Core Data model
            self.status = try container.decode(String.self, forKey: .status)
        } catch {
            print("Game didn't have score info")
            print(error)
        }
    }
}
