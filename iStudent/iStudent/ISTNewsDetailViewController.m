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
    self.navigationItem.title = self.NewsItem.Title;
    self.DateLabel.text = self.NewsItem.PublicationDate;
    [self.ContentViewer loadHTMLString:self.NewsItem.Content baseURL:NULL];
    
    //get text from the webview as javascript
    NSString *parseString = [self.ContentViewer stringByEvaluatingJavaScriptFromString:
                            @"document.body.innerText"];

    //split into array and iterate through removing exraneous artifacts from the html
    NSArray *parsingArray = [parseString componentsSeparatedByString:@" "];
    NSMutableArray *mutParsingArray = [[NSMutableArray alloc] initWithArray:parsingArray];
    
    for (id object in mutParsingArray) {
        if ([object isEqualToString:@"p"] || [object isEqualToString:@"div"] || [object isEqualToString:@"content"])
            [mutParsingArray removeObject:object];
    }
    
    
    //rejoin the array into a string
    
    NSString *parsedAccumulator = [[mutParsingArray copy] componentsJoinedByString:@" "];
    
    //pass new parsed string to the feed
    parseString = parsedAccumulator;
    
    // UIWebview does not take NSString as a loading option...
    //[self.ContentViewer parsedAccumulator];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
