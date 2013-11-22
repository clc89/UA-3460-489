//
//  ISTNewsDetailViewController.h
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTNewsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *siteButton;
@property (weak, nonatomic) IBOutlet UITextView *newsText;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NSString *courseName;

@end
