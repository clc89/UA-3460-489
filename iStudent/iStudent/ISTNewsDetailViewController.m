//
//  ISTNewsDetailViewController.m
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTNewsDetailViewController.h"

@interface ISTNewsDetailViewController ()

@end

@implementation ISTNewsDetailViewController
{
    NSArray *news;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewsDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ISTNewsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.nameLabel = [news objectAtIndex:indexPath.row];
    }
}

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
    _nameLabel.text = _courseName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
