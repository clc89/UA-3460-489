//
//  ISTAddFeedViewController.m
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTAddFeedViewController.h"
#import "ISTNewsMasterViewController.h"
#import "Helpers.h"

@interface ISTAddFeedViewController ()

@end

@implementation ISTAddFeedViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ISTNewsMasterViewController *master = (ISTNewsMasterViewController *)[segue destinationViewController];
    
    NSString *courseKey = FEED_COURSE_NAME_KEY;
    NSString *urlKey = FEED_URL_KEY;
    
    master.NewFeed = [[NSDictionary alloc] initWithObjectsAndKeys:self.CourseName.text, courseKey, self.FeedUrl.text, urlKey, nil];
}

@end
