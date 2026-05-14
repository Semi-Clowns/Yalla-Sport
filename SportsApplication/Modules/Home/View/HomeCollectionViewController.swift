import UIKit


class HomeCollectionViewController: UICollectionViewController {
    
     var homePresenter : HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        NavigationBarManager.setupMainNav(
                for: self,
                themeTarget: self,
                themeAction: #selector(themeButtonTapped)
            )
        
        homePresenter = HomePresenter()
        homePresenter?.attachView(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBarManager.syncThemeIcon(for: self)

    }
    
    @objc private func themeButtonTapped() {
        NavigationBarManager.toggleTheme(for: self)

    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAllLeagues" {
            
            let allLeaguesVC = segue.destination as! AllLeaguesViewController
            guard let sport = sender as? Sport else{
                return
            }
            print("sasfasfwsaad \(sport)")
            allLeaguesVC.presenter = AllLeaguesPresenter(
                networkService: NetworkService(),
                displayLeaguesFor: sport.type!)
        }
        
    }
    
  

}



