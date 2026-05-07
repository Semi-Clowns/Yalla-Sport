import UIKit

extension HomeCollectionViewController :
    UICollectionViewDelegateFlowLayout,
    HomeViewControllerProtocol {
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
}
