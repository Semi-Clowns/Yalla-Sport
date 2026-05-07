//
//  OnboardingPageViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    private var presenter: OnboardingPresenterProtocol!
    private var pages = [UIViewController]()
    private let pageControl: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPageIndicatorTintColor = .primaryColor
        pageController.pageIndicatorTintColor = .primaryColor?.withAlphaComponent(0.3)
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()

    private let skipButton: UIButton = {
        let skipButton = UIButton(type: .system)
        let attrs: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.secondaryText ?? .gray,
            .font: UIFont.systemFont(ofSize: 15)
        ]
        skipButton.setAttributedTitle(NSAttributedString(string: "Skip", attributes: attrs), for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        return skipButton
    }()

    private let actionButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next →", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        nextButton.backgroundColor = .primaryColor
        nextButton.layer.cornerRadius = 14
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .BackgroundColor
        presenter = OnboardingPresenter(view: self)
        setupPages()
        setupUI()
        presenter.viewDidLoad()
    }

    private func setupPages() {
        dataSource = self
        delegate = self

        pages = presenter.getPages().compactMap {
            storyboard?.instantiateViewController(withIdentifier: $0)
        }

        guard let first = pages.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        pageControl.numberOfPages = pages.count
    }

    private func setupUI() {
        view.addSubview(pageControl)
        view.addSubview(actionButton)
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 56),

            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -12),
        ])
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
   
    @objc private func actionTapped() {
        presenter.nextTapped(currentIndex: getCurrentIndex())
    }

    @objc private func skipTapped() {
        presenter.skipTapped()
    }

    private func getCurrentIndex() -> Int {
        guard let current = viewControllers?.first else { return 0 }
        return pages.firstIndex(of: current) ?? 0
    }
}

extension OnboardingPageViewController: OnboardingViewProtocol {

    func updateUI(index: Int, isLastPage: Bool) {
        if index != pageControl.currentPage {
            let direction: UIPageViewController.NavigationDirection = index > pageControl.currentPage ? .forward : .reverse
            setViewControllers([pages[index]], direction: direction, animated: true)
        }

        pageControl.currentPage = index
        skipButton.isHidden = isLastPage
        actionButton.setTitle(isLastPage ? "Get Started →" : "Next →", for: .normal)
    }

    func navigateToMainApp() {
        guard let HomePage = storyboard?.instantiateViewController(withIdentifier: "HomePage") else { return }
        navigationController?.pushViewController(HomePage, animated: true)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed else { return }
        presenter.didSwipeToPage(index: getCurrentIndex())
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


