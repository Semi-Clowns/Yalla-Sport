import UIKit

extension HomeCollectionViewController :
    UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = collectionView.safeAreaLayoutGuide.layoutFrame
        let padding: CGFloat = 10
        
        let width = (frame.width - (padding * 3)) / 2
        let height = (frame.height - (padding * 3)) / 2
        
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
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
      
        
        homePresenter?.navigateToDisplayLeague(index:indexPath.row )
    }
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("shouldSelect")
        return true
    }
    
    
}
