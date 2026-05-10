//
//  AppAlerts.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//

import UIKit

class AppComponents {
    
    static func showAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }

    static func showNoInternet(on vc: UIViewController) {
        showAlert(on: vc,
                  title: "Connection Lost",
                  message: "Please check your internet and try again.")
    }
    
    static func showConfirmation(on vc: UIViewController, title: String, message: String, confirmTitle: String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive) { _ in
            action()
        })
        
        vc.present(alert, animated: true)
    }
    static func showLoading(on vc: UIViewController){
            let loadingView = UIView(frame: vc.view.bounds)
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            loadingView.tag = 999
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .white
            activityIndicator.center = loadingView.center
            activityIndicator.startAnimating()

            loadingView.addSubview(activityIndicator)
            vc.view.window?.addSubview(loadingView)
            
        }
        
        static func hideLoading(on vc: UIViewController) {
            vc.view.viewWithTag(999)?.removeFromSuperview()
        }
}
