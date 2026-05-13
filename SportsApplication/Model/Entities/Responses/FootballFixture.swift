//
//  FootballFixture.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation

struct FootballFixturesResponse: Codable {
    let success: Int?
    let result: [FootballFixture]?
}

struct FootballFixture: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let leagueRound: String?
    
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    
    let eventFinalResult: String?
    let leagueName: String?
    let eventStadium: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case leagueName = "league_name"
        case eventStadium = "event_stadium"
        case leagueRound = "league_round"
    }
}

extension FootballFixture {
    func toEvent() -> Event {
        return Event(
            eventId: "\(eventKey ?? 0)",
            eventDate: eventDate ?? "",
            eventTime: eventTime ?? "",
            leagueRound: leagueRound ?? "",
            homeTeamName: eventHomeTeam ?? "Unknown",
            awayTeamName: eventAwayTeam ?? "Unknown",
            homeTeamLogo: homeTeamLogo,
            awayTeamLogo: awayTeamLogo,
            finalResult: eventFinalResult,
            leagueName: leagueName,
            stadium: eventStadium
        )
    }
}
