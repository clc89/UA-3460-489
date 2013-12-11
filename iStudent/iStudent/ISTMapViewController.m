//
//  ISTMapViewController.m
//  iStudent
//
//  Created by Christopher Stoll on 11/18/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTMapViewController.h"

@interface ISTMapViewController ()

@end

@implementation ISTMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MKCoordinateRegion mapRegion;
    mapRegion.center = CLLocationCoordinate2DMake(41.077810, -81.510623);;
    mapRegion.span = MKCoordinateSpanMake(0.005, 0.005);
    [self.courseMapLocation setRegion:mapRegion animated: YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(41.077810, -81.510623);
    annotation.title = @"iOS Development";
    annotation.subtitle = @"CAS 143";
    [self.courseMapLocation addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];
}

@end
