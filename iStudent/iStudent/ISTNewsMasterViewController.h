//
//  ISTNewsMasterViewController.h
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ISTNewsMasterViewController : UITableViewController

// dictionary that will hold the new entry from the add feed page
@property (copy) NSDictionary *NewFeed;

- (IBAction)saveNewFeed:(UIStoryboardSegue *)unwindSegue;

@end
