protocol HomePresenterProtocol {
    func getSportsCount() -> Int
    func getSportItem(index : Int) -> Sport
    func attachView(with view: HomeViewControllerProtocol)
}
