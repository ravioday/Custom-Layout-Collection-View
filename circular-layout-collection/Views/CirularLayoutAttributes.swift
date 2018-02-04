//
//  CirularLayoutAttributes.swift
//  circular-layout-collection
//
//  Created by Ravi Joshi on 2/1/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CirularLayoutAttributes: UICollectionViewLayoutAttributes {
    // UICollectionViewLayoutAttributes in its as-is form provides a way to specify layout related options to collection view items (cells or the supplementary views) like frame, size, z-index, transform, alpha.
    
    // Angle and anchorPoint are custom layout attributes which are very specific to the goal of achieveing circular layout. 
    
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    var angle: CGFloat = 0.0 {
        didSet{
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    // Because the collection view may copy the layout attributes, it is important that our current custom subclass conforms to the NSCopying Protocol and overrides the copy(with ) method below.
    override func copy(with zone: NSZone? = nil) -> Any {
        if let copiedAttributes = super.copy(with: zone) as? CirularLayoutAttributes {
            copiedAttributes.anchorPoint = self.anchorPoint
            copiedAttributes.angle = self.angle
            return copiedAttributes
        }
    
        return CirularLayoutAttributes()
    }
    
}
