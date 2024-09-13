//
//  Player.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/12/24.
//

import Foundation
import CoreData

class Player: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, first_name, last_name, position, height, weight, jersey_number, college, country, draft_year, draft_round, draft_number
    }

    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.first_name = try container.decode(String.self, forKey: .first_name)
        self.last_name = try container.decode(String.self, forKey: .last_name)
        self.position = try container.decode(String.self, forKey: .position)
        self.height = try container.decode(String.self, forKey: .height)
        self.weight = try container.decode(String.self, forKey: .weight)
        self.college = try container.decode(String.self, forKey: .college)
        self.country = try container.decode(String.self, forKey: .country)
        do {
            self.jersey_number = try container.decode(String.self, forKey: .jersey_number)
            self.draft_year = try container.decode(Int16.self, forKey: .draft_year)
            self.draft_round = try container.decode(Int16.self, forKey: .draft_round)
            self.draft_number = try container.decode(Int16.self, forKey: .draft_number)
        } catch {
            print("Player didn't have draft info")
            print(error)
        }
    }
}
