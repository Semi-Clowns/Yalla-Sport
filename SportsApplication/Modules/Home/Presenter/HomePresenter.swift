class HomePresenter : HomePresenterProtocol {

    

    private let networkMonitor: NetworkMonitor
    private let sportsManager = SportManager.shared
    weak var view : HomeViewControllerProtocol?
    private var selectedIndex: Int = 0

    
    func attachView(with view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    init(networkMonitor: NetworkMonitor = NetworkMonitor.shared) {
        self.networkMonitor = networkMonitor
    }

    func getSportsCount() -> Int {
        return sportsManager.getSportsCount()
    }
    
    func getSportItem(index : Int) -> Sport {
        return sportsManager.getSportAtIndex(at: index)
    }
    
    func getAdsCount() -> Int {
        return sportsManager.getAdsCount()
    }
    
    func getAdItem(index : Int) -> Sport {
        return sportsManager.getAdItem(index: index)
    }
    func getSelectedSport(at index: Int) -> String {
        sportsManager.getSportAtIndex(at: index).type ?? ""
    }
    func navigateToDisplayLeague(index: Int) {
        if networkMonitor.isConnected{
            
            self.view?.navigateToDisplayLeague(sport:getSportItem(index: index))
        }
        else{
            self.view?.showNoInternet()
            
        }
        
    }
    
}

