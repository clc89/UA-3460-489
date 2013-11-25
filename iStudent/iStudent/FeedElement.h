//
//  FeedElement.h
//  iStudent
//
//  Created by Ryan McCafferty on 11/24/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedElement : NSObject

@property (strong) NSString *Title;

@property (strong) NSString *Description;

@property (strong) NSString *PublicationDate;

@property (strong) NSString *Content;

-(void)reset;

@end
