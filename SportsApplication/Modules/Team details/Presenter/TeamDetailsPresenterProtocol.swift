//
//  TeamDetailsPresenterProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import Foundation

protocol TeamDetailsPresenterProtocol {
    func attachView(with view : TeamDetailsViewControllerProtocol)
    func getTeamDetails() -> Team
    func getTeamPlayersCount() -> Int
    func getPlayerAtIndex(at index : Int) -> Player?
    func getCoach() -> Coach?
    func getTeamCoachCount() -> Int
    
}
