//
//  ISTNewsDetailViewController.h
//  iStudent
//
//  Created by Ryan McCafferty on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedElement.h"

@interface ISTNewsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *ContentViewer;

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@property (retain) FeedElement *NewsItem;

@end
