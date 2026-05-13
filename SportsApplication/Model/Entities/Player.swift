//
//  Player.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import Foundation

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
