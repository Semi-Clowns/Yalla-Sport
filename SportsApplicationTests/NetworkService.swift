//
//  NetworkServiceFixtures.swift
//  SportsApplicationTests
//
//  Created by Moaz on 13/05/2026.
//

import XCTest
@testable import SportsApplication

class NetworkServiceFixtures: XCTestCase {
    var networkService: NetworkService!
    
    override func setUp() {
        networkService = NetworkService()
    }
    
    // Success States
    func test_fetchFootballFixtures_returnsData() throws {
        let expectation = expectation(description: "API returns Football Fixtures")
        
        networkService.getFootballFixtures(leagueId: 152, from: "2026-04-27", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertGreaterThan(response.count, 0, "Expected fixtures but got empty")
                print("Football Fixtures count: \(response.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
    
    func test_fetchBasketballFixtures_returnsData() throws {
        let expectation = expectation(description: "API returns Basketball Fixtures")
        
        networkService.getBasketballFixtures(leagueId: 766, from: "2026-04-27", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertGreaterThan(response.count, 0, "Expected fixtures but got empty")
                print("Basketball Fixtures count: \(response.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 25)
    }
    
    func test_fetchTennisFixtures_returnsData() throws {
        let expectation = expectation(description: "API returns Tennis Fixtures")
        
        networkService.getTennisFixtures(leagueId: 13579, from: "2025-04-27", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertGreaterThan(response.count, 0, "Expected fixtures but got empty")
                print("Tennis Fixtures count: \(response.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
    
    func test_fetchCricketFixtures_returnsData() throws {
        let expectation = expectation(description: "API returns Cricket Fixtures")
        
        networkService.getCricketFixtures(leagueId: 733, from: "2020-04-27", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertGreaterThan(response.count, 0, "Expected fixtures but got empty")
                print("Cricket Fixtures count: \(response.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
    
    // Fails States
    func test_fetchFootballFixtures_invalidLeague_fails() throws {
        let expectation = expectation(description: "Football invalid league returns error or empty")

        networkService.getFootballFixtures(leagueId: 999999, from: "2026-05-01", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                // API may return success with empty result for unknown league
                XCTAssertEqual(response.count, 0, "Expected empty fixtures for invalid league")
                print("Football invalid league - count: \(response.count)")
            case .failure(let error):
                print("Football invalid league - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func test_fetchBasketballFixtures_invalidLeague_fails() throws {
        let expectation = expectation(description: "Basketball invalid league returns error or empty")

        networkService.getBasketballFixtures(leagueId: 999999, from: "2026-05-01", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 0, "Expected empty fixtures for invalid league")
                print("Basketball invalid league - count: \(response.count)")
            case .failure(let error):
                print("Basketball invalid league - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }


    func test_fetchTennisFixtures_invalidLeague_fails() throws {
        let expectation = expectation(description: "Tennis invalid league returns error or empty")

        networkService.getTennisFixtures(leagueId: 999999, from: "2026-05-01", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 0, "Expected empty fixtures for invalid league")
                print("Tennis invalid league - count: \(response.count)")
            case .failure(let error):
                print("Tennis invalid league - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }


    func test_fetchCricketFixtures_invalidLeague_fails() throws {
        let expectation = expectation(description: "Cricket invalid league returns error or empty")

        networkService.getCricketFixtures(leagueId: 999999, from: "2026-05-01", to: "2026-05-10") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 0, "Expected empty fixtures for invalid league")
                print("Cricket invalid league - count: \(response.count)")
            case .failure(let error):
                print("Cricket invalid league - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }
    
    // Team Response Succes State
    func test_fetchFootballTeams_returnsData() throws {
        let expectation = expectation(description: "API returns Football Teams")

        networkService.getTeamsFrom(leagueId: 152, sport: "football", countryName: "Egypt", countryLogo: "") { result in
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
                XCTAssertGreaterThan(teams.count, 0, "Expected teams but got empty")
                print("Football Teams count: \(teams.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func test_fetchBasketballTeams_returnsData() throws {
        let expectation = expectation(description: "API returns Basketball Teams")

        networkService.getTeamsFrom(leagueId: 766, sport: "basketball", countryName: "Egypt", countryLogo: "") { result in
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
                XCTAssertGreaterThan(teams.count, 0, "Expected teams but got empty")
                print("Basketball Teams count: \(teams.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func test_fetchCricketTeams_returnsData() throws {
        let expectation = expectation(description: "API returns Cricket Teams")

        networkService.getTeamsFrom(leagueId: 733, sport: "cricket", countryName: "", countryLogo: "") { result in
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
                XCTAssertGreaterThan(teams.count, 0, "Expected teams but got empty")
                print("Cricket Teams count: \(teams.count)")
            case .failure(let error):
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    // Teams Fails State
    func test_fetchTeams_invalidLeague_returnsEmpty() throws {
        let expectation = expectation(description: "Invalid league returns empty or error")

        networkService.getTeamsFrom(leagueId: 999999, sport: "football", countryName: "Egypt", countryLogo: "") { result in
            switch result {
            case .success(let teams):
                XCTAssertEqual(teams.count, 0, "Expected empty teams for invalid league")
                print("Invalid league teams count: \(teams.count)")
            case .failure(let error):
                print("Invalid league - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func test_fetchTeams_invalidSport_returnsEmpty() throws {
        let expectation = expectation(description: "Invalid sport returns empty or error")

        networkService.getTeamsFrom(leagueId: 152, sport: "invalidSport", countryName: "Egypt", countryLogo: "") { result in
            switch result {
            case .success(let teams):
                XCTAssertEqual(teams.count, 0, "Expected empty for invalid sport")
                print("Invalid sport teams count: \(teams.count)")
            case .failure(let error):
                print("Invalid sport - expected failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
    }
}
