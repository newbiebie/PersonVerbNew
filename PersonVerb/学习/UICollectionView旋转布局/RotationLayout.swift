//
//  RotationLayout.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
import CoreFoundation

class RotationCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    // 1
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        // 2
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    // 3
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: RotationCollectionViewLayoutAttributes =
            super.copy(with: zone) as! RotationCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
    
    
}


class RotationLayout: UICollectionViewLayout {
    
    
    //设置item的大小
    let itemSize : CGSize = CGSize.init(width: SCREENW * 0.7, height: SCREENW * 0.7 * SCREENH * 0.7 / SCREENW)
    
    let scale = SCREENH / 480
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
            -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * angleItem : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width -
           collectionView!.bounds.size.width)
    }
    
    //属性数组
    var attributesList = [RotationCollectionViewLayoutAttributes]()
    
    //设置旋转半径
    var radius : CGFloat = 500{
        didSet{
            invalidateLayout()
        }
    }
    
    //调整cell之间的距离
    var angleItem : CGFloat {
        
        return atan(itemSize.width / radius * 1.3 * scale)
    }
    
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
                      height: collectionView!.bounds.size.height)
    }

    //布局属性填充
    override func prepare() {
        super.prepare()
        
        //每次调用方法之前清空数据源数组  固定数据bug不明显, 动态数据有bug
        self.attributesList.removeAll()
        
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        let centerX = collectionView!.contentOffset.x + ((collectionView!.bounds.size.width) / 2.0)
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map { (i)
            -> RotationCollectionViewLayoutAttributes in
            
            let attributes = RotationCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

            //调整显示的位置
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.size.height / 2)
            attributes.angle = self.angle + (self.angleItem * CGFloat(i))
            return attributes
            
        }
    }
    
    
    //设置给出rect下的items的attributesList
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    //设置item用到的attribute
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    //
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //保证cell停留在中间位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var finalContentOffset = proposedContentOffset
        
        //1
        let factor = -angleAtExtreme/(collectionViewContentSize.width -
            collectionView!.bounds.size.width)
        let proposedAngle = proposedContentOffset.x*factor
        
        let ratio = proposedAngle/angleItem
        var multiplier: CGFloat
        //2
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        //3
        finalContentOffset.x = multiplier * angleItem / factor
        return finalContentOffset
    }
    
}
