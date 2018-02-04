//
//  CustomCollectionViewCell.swift
//  circular-layout-collection
//
//  Created by Ravi Joshi on 2/3/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    class func reuseIdentifier() -> String{
        return "CUSTOM_COLLECTION_VIEW_CELL"
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let circularLayoutAttributes = layoutAttributes as? CirularLayoutAttributes {
            self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
            self.center.y = self.center.y + (circularLayoutAttributes.anchorPoint.y - 0.5) * (self.bounds.height)
        }
    }

}
