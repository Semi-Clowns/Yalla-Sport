//
//  TeamDetailsPresenter.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import Foundation

class TeamDetailsPresenter : TeamDetailsPresenterProtocol {
    
    weak var view : TeamDetailsViewControllerProtocol?
    
    private let team : Team
    
    init(team : Team) {
        self.team = team
    }
    
    func attachView(with view : TeamDetailsViewControllerProtocol) {
        self.view = view
    }
    
    func getTeamDetails() -> Team {
        team
    }
    
    func getTeamPlayersCount() -> Int {
        team.players?.count ?? 0
    }
    
    func getTeamCoachCount() -> Int {
        team.coaches?.count ?? 0
    }
    
    func getPlayers() -> [Player]? {
        team.players ?? []
    }

    func getPlayerAtIndex(at index: Int) -> Player? { team.players?[index] }
    func getCoach() -> Coach? { team.coaches?.first }
}


