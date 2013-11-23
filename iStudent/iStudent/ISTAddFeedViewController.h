//
//  ISTAddFeedViewController.h
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTAddFeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *CourseName;


@property (weak, nonatomic) IBOutlet UITextField *FeedUrl;


@property (weak, nonatomic) IBOutlet UIButton *CancelNew;

@end
