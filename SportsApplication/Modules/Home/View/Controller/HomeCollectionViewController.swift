import UIKit

protocol HomeViewControllerProtocol : AnyObject {
    func showNoInternet()
    func navigateToDisplayLeague()
}

class HomeCollectionViewController: UICollectionViewController {
    
    private var homePresenter : HomePresenterProtocol?
    private var selectedIndex: Int = 0

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

    // Compositional Layout Setup
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.85),
                    heightDimension: .absolute(200)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
                
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(220)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
                
                return section
            }
        }
    }
    @objc private func themeButtonTapped() {
        NavigationBarManager.toggleTheme(for: self)

    }
    override func numberOfSections	(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
                    return min(homePresenter?.getAdsCount() ?? 0, 4)
            } else {
                    return homePresenter?.getSportsCount() ?? 0
            }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
            
        if indexPath.section == 0 {
            let adItem = homePresenter?.getAdItem(index: indexPath.row) ?? Sport(title: "No Sport Item", image: "" , type: "football")
            cell.configureCell(with: adItem)
        } else {
            let sportItem = homePresenter?.getSportItem(index: indexPath.row) ?? Sport(title: "No Sport Item", image: "" , type: "football")
            cell.configureCell(with: sportItem)
        }

            cell.layer.cornerRadius = 12
            return cell
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        print("Selected : \(selectedIndex)" )
        
        homePresenter?.navigateToDisplayLeague()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAllLeagues" {
            
            let allLeaguesVC = segue.destination as! AllLeaguesViewController
            
            let sport = homePresenter?.getSelectedSport(at: selectedIndex) ?? "football"
            print("Sport from Home : \(sport)")
            
            allLeaguesVC.presenter = AllLeaguesPresenter(
                networkService: NetworkService(),
                displayLeaguesFor: sport)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("shouldSelect")
        return true
    }
    

}

extension HomeCollectionViewController :HomeViewControllerProtocol {
    func showNoInternet() {
        AppAlerts.showNoInternet(on: self)
        }
    func navigateToDisplayLeague() {
        performSegue(withIdentifier: "goToAllLeagues", sender: nil)
    }
}


