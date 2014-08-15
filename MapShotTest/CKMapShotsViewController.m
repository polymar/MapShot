//
//  CKMapShotsViewController.m
//  MapShotTest
//
//  Created by openovo on 8/14/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import "CKMapShotsViewController.h"
#import "CKMapShotCollectionCell.h"
#import "CKMapShotsCollectionViewLayout.h"

@interface CKMapShotsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) NSMutableArray* maps;
@property(nonatomic, strong) NSOperationQueue *imageQueue;
@property(nonatomic, strong) NSMutableDictionary* imageCache;

@end

@implementation CKMapShotsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.maps = [NSMutableArray array];
    self.imageQueue = [[NSOperationQueue alloc] init];
    self.imageQueue.maxConcurrentOperationCount = 3;
    
    self.imageCache = [[NSMutableDictionary alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    for (int count = 0; count < (int)[directoryContent count]; count++)
    {
        [self.maps addObject:[documentsDirectory stringByAppendingPathComponent:[directoryContent objectAtIndex:count]]];
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CKMapShotCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CKMapShotsCollectionCell"];
    
    self.collectionView.collectionViewLayout = [[CKMapShotsCollectionViewLayout alloc] init];
}

#pragma mark -
#pragma mark UICollectionViewDelegate

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return self.maps.count;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CKMapShotCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CKMapShotsCollectionCell" forIndexPath:indexPath];
    NSString* imagePath = [self.maps objectAtIndex:(indexPath.section * 2) + indexPath.row];
    UIImage* image = [self.imageCache objectForKey:imagePath];
    if (image)
    {
        cell.mapImageView.image = image;
    }
    else
    {
        cell.mapImageView.image = nil; //placeholder
        // load photo images in the background
        __weak CKMapShotsViewController *weakSelf = self;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // then set them via the main queue if the cell is still visible.
                if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                    CKMapShotCollectionCell *cell = (CKMapShotCollectionCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                    cell.mapImageView.image = image;
                }
                [weakSelf.imageCache setObject:image forKey:imagePath];
            });
        }];
        
        [self.imageQueue addOperation:operation];
    }
    return cell;
}

@end
