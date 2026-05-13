//
//  CricketFixture.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation

struct CricketFixturesResponse: Codable {
    let success: Int?
    let result: [CricketFixture]?
}

struct CricketFixture: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let leagueRound: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    
    let eventFinalResult: String?
    let leagueName: String?
    let eventStadium: String?
    
    let eventHomeTeamLogo : String?
    let eventAwayTeamLogo : String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventFinalResult = "event_final_result"
        case leagueName = "league_name"
        case eventStadium = "event_stadium"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case leagueRound = "league_round"
    }
}

extension CricketFixture {
    func toEvent() -> Event {
        return Event(
            eventId: "\(eventKey ?? 0)",
            eventDate: eventDate ?? "",
            eventTime: eventTime ?? "",
            leagueRound: leagueRound ?? "",
            homeTeamName: eventHomeTeam ?? "Unknown",
            awayTeamName: eventAwayTeam ?? "Unknown",
            homeTeamLogo: eventHomeTeamLogo ?? "",
            awayTeamLogo: eventAwayTeamLogo ?? "",
            finalResult: eventFinalResult,
            leagueName: leagueName,
            
            stadium: eventStadium
            
        )
    }
}
