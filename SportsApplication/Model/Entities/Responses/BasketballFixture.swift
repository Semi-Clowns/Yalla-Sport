//
//  BasketballFixture.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation

struct BasketballFixturesResponse: Codable {
    let success: Int?
    let result: [BasketballFixture]?
}

struct BasketballFixture: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    
    let eventFinalResult: String?
    let leagueName: String?
    
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
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
    }
}

extension BasketballFixture {
    func toEvent() -> Event {
        return Event(
            eventId: "\(eventKey ?? 0)",
            eventDate: eventDate ?? "",
            eventTime: eventTime ?? "",
            homeTeamName: eventHomeTeam ?? "Unknown",
            awayTeamName: eventAwayTeam ?? "Unknown",
            homeTeamLogo: eventHomeTeamLogo ?? "",
            awayTeamLogo: eventAwayTeamLogo ?? "",
            finalResult: eventFinalResult,
            leagueName: leagueName,
            stadium: nil
        )
    }
}
