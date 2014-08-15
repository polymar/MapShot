//
//  CKMapAnnotation.h
//  MapShotTest
//
//  Created by openovo on 8/14/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CKMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic,copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(id) initWithTitle:(NSString *) title andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
