//
//  TennisFixture.swift
//  SportsApplication
//
//  Created by Moaz on 12/05/2026.
//

import Foundation

struct TennisFixturesResponse: Codable {
    let success: Int?
    let result: [TennisFixture]?
}

struct TennisFixture: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let leagueRound: String?
    let eventFirstPlayer: String?
    let eventSecondPlayer: String?
    
    
    
    let eventFinalResult: String?
    let leagueName: String?
    
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo : String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case eventSecondPlayer = "event_second_player"
        case eventFinalResult = "event_final_result"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo  = "event_second_player_logo"
        case leagueName = "league_name"
        case leagueRound = "league_round"
        
    }
}

extension TennisFixture {
    func toEvent() -> Event {
        return Event(
            eventId: "\(eventKey ?? 0)",
            eventDate: eventDate ?? "",
            eventTime: eventTime ?? "",
            leagueRound: leagueRound ?? "",
            homeTeamName: eventFirstPlayer ?? "Unknown",
            awayTeamName: eventSecondPlayer ?? "Unknown",
            homeTeamLogo: eventFirstPlayerLogo ?? "",
            awayTeamLogo: eventFirstPlayerLogo ?? "",
            finalResult: eventFinalResult,
            leagueName: leagueName,
            
            stadium: nil
        )
    }
}
