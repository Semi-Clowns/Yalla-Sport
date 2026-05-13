//
//  LeagueDetailsPresneter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//
import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    private weak var view: LeagueDetailsViewProtocol?
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    private var league: League
    private let coreDataManager: CoreDataManager
    private let networkService: NetworkProtocol
    private let sport: String
    
    init(
        view: LeagueDetailsViewProtocol,
        league: League,
        sport: String,
        networkService: NetworkProtocol = NetworkService(),
        coreDataManager: CoreDataManager = CoreDataManager.shared
    ) {
        self.view = view
        self.league = league
        self.sport = sport
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - LeagueDetailsPresenterProtocol
    
    func viewDidLoad() {
        view?.setLeagueTitle(title: league.leagueName ?? "League")
        view?.updateFavoriteButtonState(isFavorite: league.isFav)
        fetchLeagueDetails(leagueId: league.id)
//        if !(sport == "tennis") {
//            fetchTeam(leagueId: league.id, sport: sport)
//        }
    }
    
//    func fetchLeagueDetails(leagueId: Int) {
//        view?.showLoading()
//        fetchFixtures(leagueId: leagueId)
//    }
     func fetchLeagueDetails(leagueId: Int) {
        view?.showLoading()
        
        // Setup Dates
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let upcomingFrom = formatter.string(from: today)
        let upcomingTo   = formatter.string(from: calendar.date(byAdding: .day, value: 15, to: today)!)
        let latestTo = formatter.string(from: calendar.date(byAdding: .day, value: -1, to: today)!)
        let latestFrom = formatter.string(from: calendar.date(byAdding: sport == "tennis" ? .year : .day, value: sport == "tennis" ? -6 : -15, to: today)!)

        let group = DispatchGroup()
        var encounteredError: Error?

        // 1. Fetch Upcoming
        group.enter()
        callFixtures(leagueId: leagueId, from: upcomingFrom, to: upcomingTo) { [weak self] result in
            switch result {
            case .success(let events): self?.upcomingEvents = events
            case .failure(let error): encounteredError = error
            }
            group.leave()
        }

        // 2. Fetch Latest
        group.enter()
        callFixtures(leagueId: leagueId, from: latestFrom, to: latestTo) { [weak self] result in
            switch result {
            case .success(let events): self?.latestEvents = events
            case .failure(let error): encounteredError = error
            }
            group.leave()
        }

        // 3. Fetch Teams (if not tennis)
        if sport != "tennis" {
            group.enter()
            callTeams(leagueId: leagueId, sport: sport) { [weak self] result in
                switch result {
                case .success(let teams): self?.teams = teams
                case .failure(let error): encounteredError = error
                }
                group.leave()
            }
        }

        // 4. Notify when ALL are done
        group.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            
            if let error = encounteredError {
                self?.view?.showError(message: error.localizedDescription)
            } else {
                self?.view?.reloadCollectionView()
            }
        }
    }
    
    func toggleFavorite() {
        do {
            if !league.isFav {
                try coreDataManager.addToFavourites(league: league)
                league.isFav.toggle()
                view?.updateFavoriteButtonState(isFavorite: league.isFav)
            } else {
                view?.showDeleteAlert(leagueId: league.id)
            }
        } catch {
            view?.showError(message: "Failed to add favourites")
        }
    }
    
    func deleteConfirmation(leagueId: Int) {
        do {
            try coreDataManager.removeFromFavourites(leagueId: leagueId)
            league.isFav.toggle()
            view?.updateFavoriteButtonState(isFavorite: league.isFav)
        } catch {
            view?.showError(message: "Failed to remove favourites")
        }
    }
    
    // MARK: - Getters
    
    func getUpcomingEventsCount() -> Int { upcomingEvents.count }
    func getUpcomingEvent(at index: Int) -> Event { upcomingEvents[index] }
    
    func getLatestEventsCount() -> Int { latestEvents.count }
    func getLatestEvent(at index: Int) -> Event { latestEvents[index] }
    
    func getTeamsCount() -> Int { teams.count }
    func getTeam(at index: Int) -> Team { teams[index] }
    
    // MARK: - Private
    
    private func fetchFixtures(leagueId: Int) {
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let upcomingFrom = formatter.string(from: today)
        let upcomingTo   = formatter.string(from: calendar.date(byAdding: .day, value: 15, to: today)!)

        let latestFrom: String
        let latestTo = formatter.string(from: calendar.date(byAdding: .day, value: -1, to: today)!)

        if sport == "tennis" {
            latestFrom = formatter.string(from: calendar.date(byAdding: .year, value: -6, to: today)!)
        } else {
            latestFrom = formatter.string(from: calendar.date(byAdding: .day, value: -15, to: today)!)
        }

        fetchUpcoming(leagueId: leagueId, from: upcomingFrom, to: upcomingTo)
        fetchLatest(leagueId: leagueId, from: latestFrom, to: latestTo)
    }

    private func fetchUpcoming(leagueId: Int, from: String, to: String) {
        callFixtures(leagueId: leagueId, from: from, to: to) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self.upcomingEvents = events
                    self.view?.reloadCollectionView()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    private func fetchLatest(leagueId: Int, from: String, to: String) {
        callFixtures(leagueId: leagueId, from: from, to: to) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success(let events):
                    self.latestEvents = events
                    self.view?.reloadCollectionView()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchTeam(leagueId: Int, sport: String) {
        callTeams(leagueId: leagueId, sport: sport) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success(let teams):
                    self.teams = teams
                    self.view?.reloadCollectionView()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    private func callTeams(leagueId: Int, sport: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        networkService.getTeamsFrom(leagueId: leagueId, sport: sport, completion: completion)
    }
    
    
    private func callFixtures(leagueId: Int, from: String, to: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        switch sport {
        case "football":   networkService.getFootballFixtures(leagueId: leagueId, from: from, to: to, completion: completion)
        case "basketball": networkService.getBasketballFixtures(leagueId: leagueId, from: from, to: to, completion: completion)
        case "tennis":     networkService.getTennisFixtures(leagueId: leagueId, from: from, to: to, completion: completion)
        case "cricket":    networkService.getCricketFixtures(leagueId: leagueId, from: from, to: to, completion: completion)
        default:
            let error = NSError(domain: "NetworkError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unsupported sport"])
                    completion(.failure(error))
        }
    }
    
    func isTennis() -> Bool {
         sport == "tennis"
    }
    func isCompletelyEmpty() -> Bool {
        return upcomingEvents.isEmpty && latestEvents.isEmpty && teams.isEmpty
    }

    func isUpcomingEmpty() -> Bool { return upcomingEvents.isEmpty }
    func isLatestEmpty() -> Bool { return latestEvents.isEmpty }
    func isTeamsEmpty() -> Bool { return teams.isEmpty }

}
