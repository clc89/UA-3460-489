//
//  ISTCourseDetailViewController.h
//  iStudent
//
//  Created by Christopher Stoll on 11/13/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ISTCourseDetailViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) id courseItem;

@property (weak, nonatomic) IBOutlet UISwitch *courseTaken;

@property (weak, nonatomic) IBOutlet UILabel *courseNumber;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseArea;
@property (weak, nonatomic) IBOutlet UILabel *courseRequired;

@property (weak, nonatomic) IBOutlet UISegmentedControl *courseTerms;
@property (weak, nonatomic) IBOutlet UISegmentedControl *courseSections;

@property (weak, nonatomic) IBOutlet UILabel *courseInstructor;
@property (weak, nonatomic) IBOutlet UISegmentedControl *courseDays;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeBegin;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeEnd;
@property (weak, nonatomic) IBOutlet UILabel *courseLocation;

@property (weak, nonatomic) IBOutlet MKMapView *courseMapLocation;

- (IBAction)didChangeTaken:(id)sender;
- (IBAction)didChangeTerm:(id)sender;
- (IBAction)didChangeSection:(id)sender;

@end
