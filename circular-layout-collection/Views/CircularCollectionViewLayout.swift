//
//  CircularCollectionViewLayout.swift
//  circular-layout-collection
//
//  Created by Ravi Joshi on 2/1/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CircularCollectionViewLayout: UICollectionViewLayout {
    let itemSize = CGSize(width: 150, height: 250)
    var attributesList = [CirularLayoutAttributes]()
    
    var radius: CGFloat = 500 {
        // didSet Property Observer to triger an invalidateLayout to ensure that the collection view layout is updated.
        didSet{
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius) + 0.1
    }
    
    var angleAtExtreme: CGFloat {
        if let collectionView = self.collectionView {
            let totalItems = collectionView.numberOfItems(inSection: 0)
            return  -(CGFloat(totalItems - 1) * anglePerItem)
        }
        
        return 0.0
    }
    
    var angle: CGFloat {
        if let collectionView = self.collectionView {
            let maxContentOffsetX = collectionViewContentSize.width - collectionView.bounds.width
            let contentOffsetX = collectionView.contentOffset.x
            return (angleAtExtreme * (contentOffsetX / maxContentOffsetX))
        }
        return 0.0
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CirularLayoutAttributes.self
    }
    
    override var collectionViewContentSize: CGSize {
        // The Collection View Content Size determines the bounding rect around all the items to be displayed in the collection view, (similar to contentSize of the UIScrollView).
//         If the collectionViewContentSize is smaller or equal to any one dimension of the collectionView Frame, then collection view will not scroll in that direction.
        //        For example if collectionViewContentSize is (500, 480) and the collectionView: Frame is (320, 480) then the collection view will not scroll in vertical direction because the height dimension of the size is equal to the height dimension of the collectionViewFrame.
//        In this case we want to have a horizontal scroll and thus we have provided a contentSize which is wider than the frame width and just equals the frame height.
    
        if let collectionView = self.collectionView {
            let numberofItems = collectionView.numberOfItems(inSection: 0)
            let totalWidth = CGFloat(numberofItems) * itemSize.width
            let totalHeight = collectionView.frame.height
            return CGSize(width: totalWidth, height: totalHeight)
        }
        return CGSize.zero
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true ;
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {return }
        
        let centerX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        attributesList = (0..<collectionView.numberOfItems(inSection: 0)).map { (i)
            -> CirularLayoutAttributes in
            let attributes = CirularLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: collectionView.bounds.midY)
    
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
        
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var finalContentOffset = proposedContentOffset
        let factor = -angleAtExtreme / (collectionViewContentSize.width - collectionView!.bounds.width)
        let proposedAngle = proposedContentOffset.x * factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        finalContentOffset.x = multiplier * anglePerItem/factor
        return finalContentOffset
    }

}
