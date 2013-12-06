//
//  Course.h
//  iStudent
//
//  Created by Christopher Stoll on 12/6/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber * credits;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * subject;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSNumber * required;

@end
