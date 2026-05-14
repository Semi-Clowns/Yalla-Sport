//
//  LocalDatabaseServiceProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import Foundation

protocol LocalDatabaseServiceProtocol {
    func addToFavourites(league: League) throws
    func removeFromFavourites(leagueId: Int) throws
    func getAllFavourites() throws ->  [String: [League]]
    func isFavourite(leagueId: Int) -> Bool
}
