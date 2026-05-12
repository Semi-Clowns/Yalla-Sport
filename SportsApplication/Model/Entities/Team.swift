//
//  Team.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation

// MARK: - Root Response
struct TeamResponse: Codable {
    let success: Int?
    let result: [Team]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decodeIfPresent(Int.self, forKey: .success)
        if let array = try? container.decodeIfPresent([Team].self, forKey: .result) {
            result = array
        } else {
            result = nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

// MARK: - Team
struct Team: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey   = "team_key"
        case teamName  = "team_name"
        case teamLogo  = "team_logo"
        case players
        case coaches
    }
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int
    let playerImage: String?
    let playerName: String
    let playerNumber: String?
    let playerCountry: String?
    let playerType: PlayerType
    let playerAge: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    let playerInjured: String?
    let playerSubstituteOut: String?
    let playerSubstitutesOnBench: String?
    let playerAssists: String?
    let playerBirthdate: String?
    let playerIsCaptain: String?
    let playerRating: String?

    enum CodingKeys: String, CodingKey {
        case playerKey              = "player_key"
        case playerImage            = "player_image"
        case playerName             = "player_name"
        case playerNumber           = "player_number"
        case playerCountry          = "player_country"
        case playerType             = "player_type"
        case playerAge              = "player_age"
        case playerMatchPlayed      = "player_match_played"
        case playerGoals            = "player_goals"
        case playerYellowCards      = "player_yellow_cards"
        case playerRedCards         = "player_red_cards"
        case playerInjured          = "player_injured"
        case playerSubstituteOut    = "player_substitute_out"
        case playerSubstitutesOnBench = "player_substitutes_on_bench"
        case playerAssists          = "player_assists"
        case playerBirthdate        = "player_birthdate"
        case playerIsCaptain        = "player_is_captain"
        case playerRating           = "player_rating"
    }
}

// MARK: - PlayerType
enum PlayerType: String, Codable {
    case goalkeepers = "Goalkeepers"
    case defenders   = "Defenders"
    case midfielders = "Midfielders"
    case forwards    = "Forwards"
    case unknown     = "Unknown"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = PlayerType(rawValue: value) ?? .unknown
    }
}

// MARK: - Coach
struct Coach: Codable {
    let coachName: String
    let coachCountry: String?
    let coachAge: Int?

    enum CodingKeys: String, CodingKey {
        case coachName    = "coach_name"
        case coachCountry = "coach_country"
        case coachAge     = "coach_age"
    }
}

extension Coach {
    func asPlayer() -> Player {
        Player(
            playerKey: 0,
            playerImage: nil,
            playerName: coachName,
            playerNumber: "",
            playerCountry: coachCountry,
            playerType: .forwards, // placeholder
            playerAge: coachAge.map { String($0) } ?? "-",
            playerMatchPlayed: "",
            playerGoals: "",
            playerYellowCards: "",
            playerRedCards: "",
            playerInjured: "",
            playerSubstituteOut: "",
            playerSubstitutesOnBench: "",
            playerAssists: "",
            playerBirthdate: "",
            playerIsCaptain: "",
            playerRating: ""
        )
    }
}
