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
    
    if (self.courseItem) {
        NSString *thisCourseNumber = [[NSString alloc] initWithFormat:@"%@:%@", [self.courseItem valueForKey:@"subject"], [self.courseItem valueForKey:@"number"]];
        
        [self.courseNumber setText:thisCourseNumber];
        [self.courseName setText:[[self.courseItem valueForKey:@"name"] description]];
        [self.courseArea setText:@""];
        [self.courseRequired setText:@""];
        
        [self.courseInstructor setText:@""];
        [self.courseTimeBegin setText:@""];
        [self.courseTimeEnd setText:@""];
        [self.courseLocation setText:@""];
        
        if ([[self.courseItem valueForKey:@"taken"]  isEqual:@YES]) {
            [self.courseTaken setOn:YES animated:YES];
        }else{
            [self.courseTaken setOn:NO];
        }
    }
    
    self.courseMapLocation.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation {
    
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

- (IBAction)didChangeTaken:(id)sender {
    if ([sender isOn]) {
        [self.courseItem setValue:@YES forKey:@"taken"];
    }else{
        [self.courseItem setValue:@NO forKey:@"taken"];
    }
}

- (IBAction)didChangeTerm:(id)sender {
}

- (IBAction)didChangeSection:(id)sender {
    
}

@end
