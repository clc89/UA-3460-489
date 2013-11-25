//
//  CourseReader.m
//  iStudent
//
//  Created by Corey Conley on 11/24/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "CourseReader.h"


@interface CourseReader (){
    NSString* documentPlistPath;
}
-(NSDictionary *)initializeDataFrompList;
@end

@implementation CourseReader


-(NSDictionary *)initializeDataFrompList{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [paths objectAtIndex:0];
    self->documentPlistPath = [documentsPath stringByAppendingString:@"Data"];
    NSString* plistPath = self->documentPlistPath;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    
    NSDictionary *courseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    return courseData;
}

@end
