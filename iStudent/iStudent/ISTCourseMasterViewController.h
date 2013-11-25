//
//  ISTSecondViewController.h
//  iStudent
//
//  Created by Christopher Stoll on 11/8/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CourseReader.h"

@interface ISTCourseMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSDictionary *courseList;
@property (strong, nonatomic) CourseReader *reader;
@end
