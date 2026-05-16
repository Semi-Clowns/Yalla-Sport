//
//  NetworkServicetTest.swift
//  SportsApplicationTests
//
//  Created by Mahmoud  Raafat  on 16/05/2026.
//

import XCTest
@testable import SportsApplication

class NetworkServiceTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
    }
    
    override func tearDown() {
        mockNetworkService = nil
        super.tearDown()
    }
    
    // test Success and retuen leagues
    func test_fetchFootballFixtures_returnsData() throws {
        let dummyFixture = FootballFixture(
            eventKey: 12345,
            eventDate: "2026-04-27",
            eventTime: "20:45",
            leagueRound: "Quarter-finals",
            eventHomeTeam: "Al Ahly",
            eventAwayTeam: "Zamalek",
            homeTeamLogo: "https://example.com/logo1.png",
            awayTeamLogo: "https://example.com/logo2.png",
            eventFinalResult: "2-1",
            leagueName: "Egyptian Premier League",
            eventStadium: "Cairo International Stadium"
        )
        
        let expectedResponse = FootballFixturesResponse(success: 1, result: [dummyFixture])
        mockNetworkService.mockResponse = expectedResponse
        mockNetworkService.shouldReturnError = false
        
        var returnedEvent: [Event]?
        
        mockNetworkService.getFootballFixtures(leagueId: 152, from: "2026-04-27", to: "2026-05-10") { result in
            if case .success(let events) = result {
                returnedEvent = events
            }
        }
        
        XCTAssertNotNil(returnedEvent, "Events should not be nil")
        XCTAssertEqual(returnedEvent?.count, 1)
        
        XCTAssertEqual(returnedEvent?.first?.eventId, "12345")
        XCTAssertEqual(returnedEvent?.first?.homeTeamName, "Al Ahly")
        XCTAssertEqual(returnedEvent?.first?.finalResult, "2-1")
    }
    // test Success and retuen empty leagues

    func test_fetchFootballFixtures_emptyLeague_returnsEmpty() throws {
        let emptyResponse = FootballFixturesResponse(success: 1,result: [])
        mockNetworkService.mockResponse = emptyResponse
        mockNetworkService.shouldReturnError = false

        var returnedEvent: [Event]?
        mockNetworkService.getFootballFixtures(leagueId: 0, from: "2026-05-01", to: "2026-05-10") { result in
            if case .success(let events) = result {
                returnedEvent = events
            }
            
        }
        XCTAssertNotNil(returnedEvent)
        XCTAssertEqual(returnedEvent?.count, 0, "Expected empty fixtures")
    }


    func test_fetchFootballFixtures_networkFailure_returnsError() throws {
        mockNetworkService.shouldReturnError = true

        var capturedError: Error?

        mockNetworkService.getFootballFixtures(leagueId: 152, from: "2026-04-27", to: "2026-05-10") { result in
            if case .failure(let error) = result {
                capturedError = error
            }
        }

        XCTAssertNotNil(capturedError, "network failure error ")
    }


    func test_fetchFootballTeams_returnsData() throws {
        let expectedResponse = TeamResponse(success: 1, result: [Team(
            teamKey: 152,
            teamName: "Al Ahly",
            teamLogo: "ahly_logo.png",
            players: nil,
            coaches: nil,
            countryName: nil,
            countryLogo: nil
        )])

        mockNetworkService.mockResponse = expectedResponse
        mockNetworkService.shouldReturnError = false

        var capturedTeams: [Team]?

        mockNetworkService.getTeamsFrom(leagueId: 152, sport: "football", countryName: "Egypt", countryLogo: "logo_url") { result in
            if case .success(let teams) = result {
                capturedTeams = teams
            }
        }
        XCTAssertNotNil(capturedTeams)
        XCTAssertGreaterThan(capturedTeams?.count ?? 0, 0)
        XCTAssertEqual(capturedTeams?.first?.countryName, "Egypt","should return the same country ")
    }
    func test_fetchFootballTeams_emptyLeague_returnsEmpty() throws {
            let emptyResponse = TeamResponse(success: 1, result: [])
            mockNetworkService.mockResponse = emptyResponse
            mockNetworkService.shouldReturnError = false
            
            var capturedTeams: [Team]?
            mockNetworkService.getTeamsFrom(leagueId: 0, sport: "football", countryName: "Egypt", countryLogo: "logo_url") { result in
                if case .success(let teams) = result {
                    capturedTeams = teams
                }
            }
            
            XCTAssertNotNil(capturedTeams, "teams array should not be nil")
            XCTAssertEqual(capturedTeams?.count, 0, "Expected an empty teams")
        }
        
        func test_fetchFootballTeams_networkFailure_returnsError() throws {
            mockNetworkService.shouldReturnError = true
            
            var capturedError: Error?
            
            mockNetworkService.getTeamsFrom(leagueId: 152, sport: "football", countryName: "Egypt", countryLogo: "logo_url") { result in
                if case .failure(let error) = result {
                    capturedError = error
                }
            }
            
            XCTAssertNotNil(capturedError, "network failure error")
        }
}
