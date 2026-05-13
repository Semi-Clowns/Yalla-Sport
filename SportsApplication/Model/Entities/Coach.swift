//
//  Coach.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import Foundation

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
            playerType: .coach, // placeholder
            playerAge: coachAge.map { String($0) } ?? "",
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
