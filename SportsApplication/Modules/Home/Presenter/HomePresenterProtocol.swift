protocol HomePresenterProtocol {
    func getSportsCount() -> Int
    func getSportItem(index : Int) -> Sport
    func attachView(with view: HomeViewControllerProtocol)
    func getSelectedSport(at index: Int) -> String
    func navigateToDisplayLeague()
}
