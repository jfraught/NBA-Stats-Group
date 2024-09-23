//
//  Game.swift
//  NBA-Stats
//
//  Created by Deseret Baker on 9/22/24.
//

// Game.swift
import Foundation

struct Game: Decodable {
    let id: Int
    let date: String
    let homeTeam: TeamInfo
    let visitorTeam: TeamInfo
    let homeTeamScore: Int
    let visitorTeamScore: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeam = "home_team"
        case visitorTeam = "visitor_team"
        case homeTeamScore = "home_team_score"
        case visitorTeamScore = "visitor_team_score"
        case status
    }
}

struct TeamInfo: Decodable {
    let id: Int
    let abbreviation: String
    let full_name: String
}
