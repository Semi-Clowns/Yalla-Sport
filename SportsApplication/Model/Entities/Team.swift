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
    init(success: Int?, result: [Team]?) {
            self.success = success
            self.result = result
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
    var countryName: String?
    var countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case teamKey   = "team_key"
        case teamName  = "team_name"
        case teamLogo  = "team_logo"
        case countryName
        case countryLogo
        case players
        case coaches
    }
}

extension Team {
    mutating func setCountryName(countryName: String){
        self.countryName = countryName
    }
    
    mutating func setCountryLogo(countryLogo: String){
        self.countryLogo = countryLogo
    }
}
