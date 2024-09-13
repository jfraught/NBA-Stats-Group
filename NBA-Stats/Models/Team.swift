//
//  Team.swift
//  NBA-Stats
//
//  Created by Brayden Lemke on 3/7/24.
//

import Foundation
import CoreData

class Team: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, conference, division, city, name, full_name, abbreviation
    }

    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.conference = try container.decode(String.self, forKey: .conference)
        self.division = try container.decode(String.self, forKey: .division)
        self.city = try container.decode(String.self, forKey: .city)
        self.name = try container.decode(String.self, forKey: .name)
        self.full_name = try container.decode(String.self, forKey: .full_name)
        self.abbreviation = try container.decode(String.self, forKey: .abbreviation)
    }
    
    
}
