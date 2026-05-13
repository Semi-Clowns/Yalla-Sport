//
//  NetworkService+Fixtures.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation
import Alamofire

extension NetworkService {

    func getFootballFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey,
            "from": from,
            "to" : to

        ]

        request(
            sport: "football",
            method: "GET",
            parameters: params,
            responseType: FootballFixturesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                print("✅ Response: \(response)")
                print("✅ Result count: \(response.result?.count ?? -1)")
                let events = (response.result ?? []).map { $0.toEvent() }
                completion(.success(events))
            case .failure(let error):
                print("❌ Error: \(error)")
                print("❌ Error description: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    func getBasketballFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey,
            "from" : from,
            "to": to
        ]

        request(
            sport: "basketball",
            method: "GET",
            parameters: params,
            responseType: BasketballFixturesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let events = (response.result ?? []).map { $0.toEvent() }
                completion(.success(events))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getTennisFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey,
            "from" : from,
            "to": to
        ]

        request(
            sport: "tennis",
            method: "GET",
            parameters: params,
            responseType: TennisFixturesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let events = (response.result ?? []).map { $0.toEvent() }
                completion(.success(events))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCricketFixtures(
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey,
            "from" : from,
            "to": to
        ]

        request(
            sport: "cricket",
            method: "GET",
            parameters: params,
            responseType: CricketFixturesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let events = (response.result ?? []).map { $0.toEvent() }
                completion(.success(events))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTeamsFrom(
        leagueId: Int,
        sport : String,
        completion: @escaping (Result<[Team], Error>) -> Void
    ) {
        let params: [String: Any] = [
            "met": "Teams",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey,
        ]

        request(
            sport: sport,
            method: "GET",
            parameters: params,
            responseType: TeamResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let teams = (response.result ?? [])
                completion(.success(teams))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private func dateString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}
