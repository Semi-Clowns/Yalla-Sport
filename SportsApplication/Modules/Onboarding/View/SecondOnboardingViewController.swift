//
//  SecondOnboardingViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import UIKit

class SecondOnboardingViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gradient = CAGradientLayer()
                gradient.colors = [
                    UIColor.clear.cgColor,
                    UIColor.black.withAlphaComponent(0.6).cgColor
                ]
                gradient.locations = [0.4, 1.0]  // gradient starts at 40% down
                gradient.frame = view.bounds
                view.layer.insertSublayer(gradient, above: backgroundImageView.layer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
