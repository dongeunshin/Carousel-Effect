//
//  ViewController.swift
//  Carousel-Effect
//
//  Created by dong eun shin on 2021/12/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if let layout = cardListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let xInset = (cardListCollectionView.bounds.width - layout.itemSize.width) / 2
            let yInset = layout.itemSize.height / 2
            layout.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: yInset)
        }
        cardListCollectionView.decelerationRate = .fast
        cardListCollectionView.isPagingEnabled = false
        
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        indexLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            guard let layout = self.cardListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

            let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
            let index: Int
            if velocity.x > 0 {
                index = Int(ceil(estimatedIndex))
            } else if velocity.x < 0 {
                index = Int(floor(estimatedIndex))
            } else {
                index = Int(round(estimatedIndex))
            }

            targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
        }
}
