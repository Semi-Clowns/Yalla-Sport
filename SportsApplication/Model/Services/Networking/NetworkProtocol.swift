//
//  NetworkProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(
        sport: String,
        method: String,
        parameters: [String: Any]?,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func getFootballFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func getBasketballFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func getTennisFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func getCricketFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func getTeamsFrom(
        leagueId: Int,
        sport: String,
        completion: @escaping (Result<[Team], Error>) -> Void
    )
}
