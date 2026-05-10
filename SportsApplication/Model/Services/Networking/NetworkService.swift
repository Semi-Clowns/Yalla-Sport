//
//   NetworkService.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation
import Alamofire

final class NetworkService: NetworkProtocol {

    func request<T: Decodable>(
        sport: SportType,
        method: String = "GET",
        parameters: [String: Any]?,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        let url = "\(Constants.baseURL)/\(sport.rawValue)/"
        
        AF.request(url,
                   method: HTTPMethod(rawValue: method),
                   parameters: parameters,
                   encoding: URLEncoding.default)
        .validate(statusCode: 200...299)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
