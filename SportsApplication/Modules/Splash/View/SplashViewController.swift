//
//  SplashViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 13/05/2026.
//
import UIKit
import Lottie

class SplashViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var lottieContainerView: UIView!

    // MARK: - Properties
    private var animationView: LottieAnimationView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }

    // MARK: - Setup
    private func setupAnimation() {
        guard !UIAccessibility.isReduceMotionEnabled else {
            navigateToMainApp()
            return
        }
        let isDark = LocalDataManager.shared.isDarkMode()
        if isDark{
            animationView = LottieAnimationView(name: "darksplash")

        }
        else{
        animationView = LottieAnimationView(name: "splash")
        }
            animationView.frame = lottieContainerView.bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0

        lottieContainerView.addSubview(animationView)

        animationView.play { [weak self] finished in
            guard finished else { return }
            self?.navigateToMainApp()
        }
    }

    // MARK: - Navigation
    private func navigateToMainApp() {
        UIView.animate(withDuration: 0.4) {
            self.view.alpha = 0
        } completion: { _ in
            self.switchToMainApp()
        }
    }

    private func switchToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let initialViewController: UIViewController
        if LocalDataManager.shared.hasSeenOnboarding() {
            initialViewController = storyboard.instantiateViewController(
                withIdentifier: "HomePage"
            )
        } else {
            initialViewController = storyboard.instantiateViewController(
                withIdentifier: "OnboardingPage"
            )
        }

        guard let windowScene = UIApplication.shared.connectedScenes
                .first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        let isDark = LocalDataManager.shared.isDarkMode() 
        window.overrideUserInterfaceStyle = isDark ? .dark : .light

        window.rootViewController = initialViewController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
    
}
