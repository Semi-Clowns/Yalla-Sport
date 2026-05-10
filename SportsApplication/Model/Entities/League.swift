//
//  League.swift
//  SportsApplication
//
//  Created by Moaz on 07/05/2026.
//

import Foundation

struct League : Codable {
    let id : Int
    let leagueName: String?
    let leagueLogo: String?
    let countryName: String?
    let countryLogo: String?
    let sportType: String?
    var isFav: Bool = false
    
    enum CodingKeys: String , CodingKey {
        case id = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
        case countryLogo = "country_logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id          = try container.decode(Int.self, forKey: .id)
        leagueName  = try container.decodeIfPresent(String.self, forKey: .leagueName)
        leagueLogo  = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        countryLogo = try container.decodeIfPresent(String.self, forKey: .countryLogo)
        sportType   = nil
        isFav       = false
    }
}
