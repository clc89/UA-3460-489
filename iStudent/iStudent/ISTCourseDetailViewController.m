//
//  ISTCourseDetailViewController.m
//  iStudent
//
//  Created by Christopher Stoll on 11/13/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTCourseDetailViewController.h"

@interface ISTCourseDetailViewController ()

@end

@implementation ISTCourseDetailViewController

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
    self.courseMapLocation.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.courseMapLocation.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.02, 0.02);
    [self.courseMapLocation setRegion:mapRegion animated: YES];
}

- (IBAction)didChangeTaken:(id)sender {
}

- (IBAction)didChangeTerm:(id)sender {
}

- (IBAction)didChangeSection:(id)sender {
}

@end
