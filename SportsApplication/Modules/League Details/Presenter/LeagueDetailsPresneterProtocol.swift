//
//  LeagueDetailsPresneterProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol{
    func fetchLeagueDetails(leagueId: Int)
    func toggleFavorite()
    
    func getUpcomingEventsCount() -> Int
    func getUpcomingEvent(at index: Int) -> Event
    
    func deleteConfirmation(leagueId: Int)
    
    func getLatestEventsCount() -> Int
    func getLatestEvent(at index: Int) -> Event
    
    func viewDidLoad()
    
    func getTeamsCount() -> Int
    func getTeam(at index: Int) -> Team
    
    func isTennis() -> Bool
    func isCompletelyEmpty() -> Bool
    func isUpcomingEmpty() -> Bool
    func isLatestEmpty() -> Bool
    func isTeamsEmpty() -> Bool
    
    

}
