//
//  LeagueResponse.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation

struct LeagueResponse: Codable {
    let success: Int
    let result: [League]
}

