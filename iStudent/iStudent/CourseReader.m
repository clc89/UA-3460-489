//
//  CourseReader.m
//  iStudent
//
//  Created by Corey Conley on 11/24/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "CourseReader.h"

@implementation CourseReader


-(NSDictionary *)initializeDataFrompList{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CourseSeed" ofType:@"plist"];
    NSDictionary *courseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    return courseData;
}

@end
