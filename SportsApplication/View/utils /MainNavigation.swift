//
//  MainNavigation.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 13/05/2026.
//
import UIKit

class NavigationBarManager {
    
    static func setupMainNav(for viewController: UIViewController, themeTarget: Any?, themeAction: Selector) {
        
        let iconImageView = UIImageView(image: UIImage(named: "AppIcon"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 8
        iconImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        let leftItem = UIBarButtonItem(customView: iconImageView)
        viewController.navigationItem.leftBarButtonItem = leftItem

        let titleLabel = UILabel()
        titleLabel.text = "Yalla Sport"
        titleLabel.font = UIFont(name: "Mulish-SemiBold", size: 18)
        titleLabel.textColor = .primaryColor
        titleLabel.sizeToFit()
        viewController.navigationItem.titleView = titleLabel
        
        let themeButton = UIBarButtonItem(
            image: UIImage(systemName: "circle.lefthalf.filled"),
            style: .plain,
            target: themeTarget,
            action: themeAction
        )
        themeButton.tintColor = .primaryColor
        viewController.navigationItem.rightBarButtonItem = themeButton
    }
    static func syncThemeIcon(for viewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let isDark = window.overrideUserInterfaceStyle == .dark
        viewController.navigationItem.rightBarButtonItem?.image = UIImage(
            systemName: isDark ? "sun.max.fill" : "moon.fill"

        )
    }
    static func toggleTheme(for viewController: UIViewController) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let isDark = window.overrideUserInterfaceStyle == .dark
            let newStyle: UIUserInterfaceStyle = isDark ? .light : .dark
            
            UserDefaults.standard.set(newStyle == .dark, forKey: "isDarkMode")
            
            UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
                window.overrideUserInterfaceStyle = newStyle
                viewController.navigationItem.rightBarButtonItem?.image = UIImage(
                    systemName: newStyle == .dark ? "sun.max.fill" : "moon.fill"

                )
            }
        }
}
