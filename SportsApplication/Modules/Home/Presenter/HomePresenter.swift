final class HomePresenter : HomePresenterProtocol {
    var sports = [Sport]()
    weak var view : HomeViewControllerProtocol?
    
    func attachView(with view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    init() {
        sports.append(Sport(title: "Football", image: "football_bg"))
        sports.append(Sport(title: "BasketBall", image: "basketball_bg"))
        sports.append(Sport(title: "Cricket", image: "cricket_bg"))
        sports.append(Sport(title: "Tennis", image: "tennis_bg"))
    }
    
    func getSportsCount() -> Int {
         return sports.count
    }
    
    func getSportItem(index : Int) -> Sport {
         return sports[index]
    }
}

