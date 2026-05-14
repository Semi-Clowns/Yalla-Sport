import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var sportLabel: UILabel!
    @IBOutlet var sportImageView: UIImageView!
    
    func configureCell(with sport : Sport) {
        sportLabel.text = sport.title ?? ""
        sportImageView.image = UIImage(named: sport.image)
    }
}
