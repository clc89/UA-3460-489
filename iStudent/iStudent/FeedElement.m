//
//  FeedElement.m
//  iStudent
//
//  Created by Ryan McCafferty on 11/24/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "FeedElement.h"

@implementation FeedElement

-(id)init
{
    self = [super init];
    self.Title = @"";
    self.Description = @"";
    self.PublicationDate = @"";
    self.Content = @"";
    
    return self;
}

-(void)reset
{
    self.Title = @"";
    self.Description = @"";
    self.PublicationDate = @"";
    self.Content = @"";
}
@end
