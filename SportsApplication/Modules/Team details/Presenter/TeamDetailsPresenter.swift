//
//  TeamDetailsPresenter.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import Foundation

class TeamDetailsPresenter : TeamDetailsPresenterProtocol {
    
    weak var view : TeamDetailsViewControllerProtocol?
    
    private let team = Team(
        coachName: "Pep Guardiola",
        players: [
            Player(name: "Kevin De Bruyne", position: "Midfielder"),
            Player(name: "Erling Haaland",  position: "Forward"),
            Player(name: "Phil Foden",      position: "Winger"),
            Player(name: "Rúben Dias",      position: "Defender"),
            Player(name: "Ederson",         position: "Goalkeeper")
        ]
    )
    
    init() {
        
    }
    
    func attachView(with view : TeamDetailsViewControllerProtocol) {
        self.view = view
    }
    
    func getTeamDetails() -> Team {
        team
    }
    
    func getTeamPlayersCount() -> Int {
        team.players.count
    }
    
    func getPlayers() -> [Player] {
        team.players
    }
    
    func getPlayerAtIndex(at index : Int) -> Player {
        team.players[index]
    }
}


// We gonna Remove or Replace it
struct Player {
    let name: String
    let position: String
}

struct Team {
    let coachName: String
    let players: [Player]
}


