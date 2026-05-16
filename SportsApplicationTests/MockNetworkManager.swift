//
//  MockNetworkManager.swift
//  SportsApplicationTests
//
//  Created by Mahmoud  Raafat  on 16/05/2026.
//
import Foundation
@testable import SportsApplication

class MockNetworkService: NetworkProtocol {
    var shouldReturnError = false
    var mockResponse: Decodable?
    
  
    
    func request<T: Decodable>(
        sport: String,
        method: String,
        parameters: [String : Any]?,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if shouldReturnError {
            completion(.failure(MockError.simulatedNetworkFailure))
            return
        }
        
        if let mockData = mockResponse as? T {
            completion(.success(mockData))
        } else {
        
            completion(.failure(MockError.simulatedNetworkFailure))
        }
    }
}
enum MockError: Error {
    case simulatedNetworkFailure
}
