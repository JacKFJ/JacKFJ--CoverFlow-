//
//  FJDiyLayout.m
//  无限轮播加动画内存优化demo
//
//  Created by mac on 7/31/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "FJDiyLayout.h"

@implementation FJDiyLayout

-(void)prepareLayout{
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/3, 150);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 30;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray * arrayAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat CenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    for(UICollectionViewLayoutAttributes * attr  in arrayAtts){
        CGFloat distance = ABS(attr.center.x - CenterX);
        CGFloat scale = self.collectionView.bounds.size.width / (self.collectionView.bounds.size.width + distance);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return arrayAtts;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
//}
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
//{
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5 ;
    //可视化区域:
    CGRect visibleRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray * arrayAttrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    //记录最中心的那个cell
    int min_idx = 0;
    UICollectionViewLayoutAttributes * minattr = arrayAttrs[min_idx];
    for (int i = 1; i < arrayAttrs.count; ++i) {
        CGFloat distance1 = ABS(minattr.center.x - centerX);
        UICollectionViewLayoutAttributes * curattr = arrayAttrs[i];
        CGFloat distance2 = ABS(curattr.center.x - centerX);
        if(distance2 < distance1)
        {
            minattr = curattr;
        }
    }
    
    CGFloat offsetX = minattr.center.x - centerX;
    
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
}

@end
