struct Sport {
    var title : String?
    let image : String
    var type : String?
}

class SportManager {
    
    static let shared = SportManager()
    
    private let ads: [Sport] = [
        Sport(image: "football-stadium"),
        Sport(image: "basketball-stadium"),
        Sport(image: "cricket-stadium"),
        Sport(image: "tennis-stadium")
    ]
    
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
    
    func getAds() -> [Sport] {
        self.ads
    }
    
    func getAdsCount() -> Int {
        self.ads.count
    }
    
    func getAdItem(index : Int) -> Sport {
        self.ads[index]
    }
}
