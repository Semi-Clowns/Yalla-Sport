struct Sport {
    let title : String
    let image : String
    let type : String
}

class SportManager {
    
    static let shared = SportManager()
    
    private let sports: [Sport] = [
        Sport(title: "Football", image: "football_bg" ,type: "football"),
        Sport(title: "BasketBall", image: "basketball_bg", type: "basketball"),
        Sport(title: "Cricket", image: "cricket_bg", type: "cricket"),
        Sport(title: "Tennis", image: "tennis_bg", type: "tennis")
    ]
    
    private init(){}
    
    func getSports() -> [Sport] {
        self.sports
    }
    
    func getSportAtIndex(at index: Int) -> Sport {
        self.sports[index]
    }
    
    func getSportsCount() -> Int {
        self.sports.count
    }
}
