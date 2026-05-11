//
//  File.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit

extension LeagueDetailsCollectionViewController : TeamEventCellDelegate {
    func didTeam(_ cell: TeamEventCollectionViewCell) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TeamDetailsView") as? TeamDetailsViewController else {
                print("Error Occured")
                return}
            print("vc initaite ")
            navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
