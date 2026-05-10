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
}
