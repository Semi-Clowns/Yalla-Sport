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
}
