//
//  DiyCollectionViewCell.h
//  无限轮播加动画内存优化demo
//
//  Created by mac on 7/31/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab;

@property (nonatomic, assign) int num ;

@property (nonatomic, copy) NSString * str;
@end
