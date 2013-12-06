//
//  ISTAppDelegate.h
//  iStudent
//
//  Created by Christopher Stoll on 11/8/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
