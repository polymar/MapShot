//
//  CKViewController.m
//  MapShotTest
//
//  Created by openovo on 8/14/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import "CKViewController.h"
#import "CKMapShotsViewController.h"
#import "CKMapAnnotation.h"

@interface CKViewController () <MKMapViewDelegate>

@property(nonatomic, strong) NSMutableArray* annotations;

@end

@implementation CKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MapShot";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showDetails:)];
    
    self.annotations = [NSMutableArray array];
    CLLocationCoordinate2D coord;
    coord.latitude = 52.372126637361177;
    coord.longitude = 4.9058837149338697;
    [self.annotations addObject:[[CKMapAnnotation alloc] initWithTitle:@"Start" andCoordinate:coord]];
    
    coord.latitude = 52.374596873245968;
    coord.longitude = 4.9052349874837485;
    [self.annotations addObject:[[CKMapAnnotation alloc] initWithTitle:@"End" andCoordinate:coord]];
    
    CLLocationCoordinate2D mapCenter;
    mapCenter.latitude = 52.372126637361177;
    mapCenter.longitude = 4.9058837149338697;
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(mapCenter, MKCoordinateSpanMake(0.1341497914679266, 0.21972655709743094));
    [self.mapView setRegion:mapRegion animated:FALSE];
    [self.mapView regionThatFits:mapRegion];
    
    self.mapView.delegate = self;
    
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(didTapMap:)];
    [self.mapView addGestureRecognizer:tapRec];
}

#pragma mark -

- (void) showDetails:(id) sender
{
    [self.navigationController pushViewController:[[CKMapShotsViewController alloc] init] animated:YES];
}

- (void) didTapMap:(UITapGestureRecognizer*) gestureRec
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark -

- (IBAction) addMarkers:(id) sender
{
    self.markersButton.selected = !self.markersButton.selected;
    if (self.markersButton.selected)
    {
        [self.mapView addAnnotations:self.annotations];
    }
    else
    {
        [self.mapView removeAnnotations:self.annotations];
    }
}

- (IBAction) addPolyline:(id) sender
{
    self.polylineButton.selected = !self.polylineButton.selected;
}

- (IBAction) takeShot:(id)sender
{
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = self.mapView.region;
    options.scale = [UIScreen mainScreen].scale;
    options.size = self.mapView.frame.size;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"map-%f", [NSDate date].timeIntervalSince1970]];
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        UIImage *image = snapshot.image;
        NSData *data = UIImagePNGRepresentation(image);
        NSLog(@"Writing map image at %@", filePath);
        [data writeToFile:filePath atomically:YES];
    }];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView* aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"MyCustomAnnotation"];
    return aView;
}

@end
