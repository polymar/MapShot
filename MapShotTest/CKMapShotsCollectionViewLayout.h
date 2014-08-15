//
//  CKMapShotsCollectionViewLayout.h
//  MapShotTest
//
//  Created by openovo on 8/15/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKMapShotsCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
