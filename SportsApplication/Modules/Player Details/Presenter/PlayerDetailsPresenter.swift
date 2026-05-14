//
//  PlayerDetailsPresenter.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import Foundation

protocol PlayerDetailsPresenterProtocol {
    func attachView(with view: PlayerDetailsViewControllerProtocol)
    func getPlayer() -> Player
    func getInfoRowsCount() -> Int
    func getInfoRowsAtIndex(at index: Int) -> PlayerInfoRow
}

class PlayerDetailsPresenter: PlayerDetailsPresenterProtocol {
    
    private var player: Player
    private var infoRows: [PlayerInfoRow] = []
    private weak var view: PlayerDetailsViewControllerProtocol?
    
    init(player: Player) {
        self.player = player
        buildInfoRows()
    }
    
    func attachView(with view: PlayerDetailsViewControllerProtocol) {
        self.view = view
        self.view?.reloadData()
    }
    
    func getPlayer() -> Player {
        player
    }
    
    func getInfoRowsCount() -> Int {
        infoRows.count
    }
    
    func getInfoRowsAtIndex(at index: Int) -> PlayerInfoRow {
        infoRows[index]
    }
    
    // MARK: - Private
    private func buildInfoRows() {
        let allRows: [PlayerInfoRow] = [
            .init(title: "Name",           value: player.playerName,                 imageURL: nil),
            .init(title: "Number",         value: player.playerNumber,               imageURL: nil),
            .init(title: "Country",        value: player.playerCountry,              imageURL: nil),
            .init(title: "Type",           value: player.playerType.rawValue,        imageURL: nil),
            .init(title: "Age",            value: player.playerAge,                  imageURL: nil),
            .init(title: "Birthdate",      value: player.playerBirthdate,            imageURL: nil),
            .init(title: "Matches Played", value: player.playerMatchPlayed,          imageURL: nil),
            .init(title: "Goals",          value: player.playerGoals,                imageURL: nil),
            .init(title: "Assists",        value: player.playerAssists,              imageURL: nil),
            .init(title: "Yellow Cards",   value: player.playerYellowCards,          imageURL: nil),
            .init(title: "Red Cards",      value: player.playerRedCards,             imageURL: nil),
            .init(title: "Rating",         value: player.playerRating,               imageURL: nil),
            .init(title: "Injured",        value: player.playerInjured,              imageURL: nil),
            .init(title: "Captain",        value: player.playerIsCaptain,            imageURL: nil),
            .init(title: "Substitute Out", value: player.playerSubstituteOut,        imageURL: nil),
            .init(title: "On Bench",       value: player.playerSubstitutesOnBench,   imageURL: nil),
        ]
        
        infoRows = allRows.filter { $0.value != nil && $0.value?.isEmpty == false }
    }
}

struct PlayerInfoRow {
    let title: String
    let value: String?
    let imageURL: String?
}
