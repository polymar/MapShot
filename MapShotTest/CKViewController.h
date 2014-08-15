//
//  CKViewController.h
//  MapShotTest
//
//  Created by openovo on 8/14/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CKViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIButton* markersButton;
@property(nonatomic, weak) IBOutlet UIButton* polylineButton;
@property(nonatomic, weak) IBOutlet UIButton* mapShotButton;

@property(nonatomic, weak) IBOutlet UIView* containerView;
@property(nonatomic, weak) IBOutlet MKMapView* mapView;

// IBActions
- (IBAction) addMarkers:(id) sender;
- (IBAction) addPolyline:(id) sender;
- (IBAction) takeShot:(id)sender;

@end
