//
//  PlayerDetailsPresenterProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import Foundation

protocol PlayerDetailsPresenterProtocol {
    func attachView(with view: PlayerDetailsViewControllerProtocol)
    func getPlayer() -> Player
    func getInfoRowsCount() -> Int
    func getInfoRowsAtIndex(at index: Int) -> PlayerInfoRow
}
