//
//  Event.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import Foundation

struct Event {
    let eventId: String
    let eventDate: String
    let eventTime: String
    let leagueRound: String?
    
    let homeTeamName: String
    let awayTeamName: String
    
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    
    let finalResult: String?
    let leagueName: String?
    let stadium: String?
}
