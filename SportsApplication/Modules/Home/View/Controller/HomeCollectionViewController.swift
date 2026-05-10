import UIKit

protocol HomeViewControllerProtocol : AnyObject {
    
}

class HomeCollectionViewController: UICollectionViewController {
    
    private var homePresenter : HomePresenterProtocol?
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        homePresenter = HomePresenter()
        homePresenter?.attachView(with: self)
        
        // spacing around collection view
        //// replace this constants for dynamic one.
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    override func numberOfSections	(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresenter?.getSportsCount() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
    
        // Configure the cell
        let sportItem = homePresenter?.getSportItem(index: indexPath.row) ?? Sport(title: "No Sport Item", image: "" , type: .football)
        cell.configureCell(with: sportItem)
        cell.layer.cornerRadius = 12
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        print("Selected : \(selectedIndex)" )
        performSegue(withIdentifier: "goToAllLeagues", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAllLeagues" {
            let allLeaguesVC = segue.destination as! AllLeaguesViewController
            
            let sport = homePresenter?.getSelectedSport(at: selectedIndex) ?? .football
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


