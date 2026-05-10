//
//  NetworkService+Leagues.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation

extension NetworkProtocol {
    
    func getAllLeagues<T: Decodable>(
        sport: SportType,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.apiKey
        ]
        
        request(
            sport: sport,
            method: "GET",
            parameters: params,
            responseType: responseType,
            completion: completion
        )
    }
}
