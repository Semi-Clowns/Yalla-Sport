final class HomePresenter : HomePresenterProtocol {
    var sports = [Sport]()
    weak var view : HomeViewControllerProtocol?
    
    func attachView(with view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    init() {
        sports.append(Sport(title: "Football", image: "football_bg" ,type: "football"))
        sports.append(Sport(title: "BasketBall", image: "basketball_bg", type: "basketball"))
        sports.append(Sport(title: "Cricket", image: "cricket_bg", type: "cricket"))
        sports.append(Sport(title: "Tennis", image: "tennis_bg", type: "tennis"))
    }
    
    
    
    func getSportsCount() -> Int {
         return sports.count
    }
    
    func getSportItem(index : Int) -> Sport {
         return sports[index]
    }
    
    func getSelectedSport(at index: Int) -> String {
        sports[index].type
    }
    
}

