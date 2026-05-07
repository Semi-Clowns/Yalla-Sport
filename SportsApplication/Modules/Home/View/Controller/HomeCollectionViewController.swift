import UIKit

protocol HomeViewControllerProtocol : AnyObject {
    
}

class HomeCollectionViewController: UICollectionViewController {
    
    private var homePresnter : HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        homePresnter = HomePresenter()
        homePresnter?.attachView(with: self)
        
        // spacing around collection view
        //// replace this constants for dynamic one.
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresnter?.getSportsCount() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
    
        // Configure the cell
        let sportItem = homePresnter?.getSportItem(index: indexPath.row) ?? Sport(title: "No Sport Item", image: "")
        cell.configureCell(with: sportItem)
        cell.layer.cornerRadius = 12
    
        return cell
    }

}


