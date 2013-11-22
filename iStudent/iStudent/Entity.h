//
//  Entity.h
//  iStudent
//
//  Created by Christopher Stoll on 11/22/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSNumber * subject;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * credits;

@end
