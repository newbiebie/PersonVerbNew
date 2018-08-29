//
//  PerfectLayout.m
//  SwiftExercise
//
//  Created by xunji on 2018/8/1.
//  Copyright © 2018年 xunji. All rights reserved.
//

#import "PerfectLayout.h"

@implementation PerfectLayout

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect rect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSMutableArray *data = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    
    CGFloat horCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2.0;
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    
    for (UICollectionViewLayoutAttributes *attribute in data){
        CGFloat centerX = attribute.center.x;
        if (fabs(centerX - horCenter) < fabs(offsetAdjustment)) {
            offsetAdjustment = centerX - horCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end
