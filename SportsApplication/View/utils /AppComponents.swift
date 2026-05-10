//
//  Components.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 10/05/2026.
//

import UIKit
class AppComponents {
    
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
            vc.view.window?.viewWithTag(999)?.removeFromSuperview()        }
}

