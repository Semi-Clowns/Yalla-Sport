//
//  LeagueDetailsPresneter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//
struct Event {
    let homeTeamName: String
    let awayTeamName: String
    let date: String
 
}

struct Team {
    let teamName: String
    let teamLogo: String
    }
import Foundation
class LeagueDetailsPresenter : LeagueDetailsPresenterProtocol{
    private weak var view : LeagueDetailsViewProtocol?
    private var upcomingEvents: [Event] = []
private var latestEvents: [Event] = []
        private var teams: [Team] = []
    private var league: League
    private let coreDataManager: CoreDataManager
    
    init(view: LeagueDetailsViewProtocol,league: League , coreDataManager :CoreDataManager = CoreDataManager.shared) {
        self.view = view
        self.league = league
        self.coreDataManager = coreDataManager
    }
    func viewDidLoad() {
        view?.setLeagueTitle(title: league.leagueName ?? "League")
            view?.updateFavoriteButtonState(isFavorite: league.isFav)
            fetchLeagueDetails(leagueId: league.id)
        }
    
    func toggleFavorite() {
        do{
            
            if !league.isFav {
                try coreDataManager.addToFavourites(league: league)
                league.isFav.toggle()
                view?.updateFavoriteButtonState(isFavorite: league.isFav)

            } else {
                view?.showDeleteAlert(leagueId: league.id)
            }
            
            
        }
        catch {
            view?.showError(message: "Failed to add favourites")
        }
        
    }
    func deleteConfirmation(leagueId: Int) {
        do{
            try coreDataManager.removeFromFavourites(leagueId: leagueId)
            league.isFav.toggle()
            view?.updateFavoriteButtonState(isFavorite: league.isFav)
        }
        catch {
            view?.showError(message: "Failed to remove favourites")
        }
        
    }
    func fetchLeagueDetails(leagueId: Int) {
        view?.showLoading()
        
       // call the api service
            
            self.upcomingEvents = [Event(homeTeamName: "Man City", awayTeamName: "Arsenal", date: "15/5"),Event(homeTeamName: "Man City", awayTeamName: "Arsenal", date: "15/5")]
            self.latestEvents = [Event(homeTeamName: "Liverpool", awayTeamName: "Chelsea", date: "10/5"),
                                 Event(homeTeamName: "Aston Villa", awayTeamName: "Spurs", date: "11/5")]
            self.teams = [Team(teamName: "Man City", teamLogo: "url"), Team(teamName: "Arsenal", teamLogo: "url")]
            
            self.view?.hideLoading()
            self.view?.reloadCollectionView()
        }

    
   
    func getUpcomingEventsCount() -> Int {
        return upcomingEvents.count
    }
    func getUpcomingEvent(at index: Int) -> Event {
        return upcomingEvents[index]
    }
    func getLatestEventsCount() -> Int {
        return latestEvents.count
    }
    func getLatestEvent(at index: Int) -> Event {
        return latestEvents[index]
    }
    
    func getTeamsCount() -> Int {
        return teams.count
    }
    func getTeam(at index: Int) -> Team {
        return teams[index]
    }
 
}
