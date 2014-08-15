//
//  CKMapAnnotation.m
//  MapShotTest
//
//  Created by openovo on 8/14/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import "CKMapAnnotation.h"

@implementation CKMapAnnotation

-(id) initWithTitle:(NSString *) title andCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}

@end
