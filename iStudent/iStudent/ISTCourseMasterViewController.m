//
//  ISTSecondViewController.m
//  iStudent
//
//  Created by Christopher Stoll on 11/8/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTCourseMasterViewController.h"

@interface ISTCourseMasterViewController ()

@end

@implementation ISTCourseMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // You must allocate memory and initialize these first -- Stoll
    self.reader = [[CourseReader alloc] init];
    self.courseList = [[NSDictionary alloc] init];
    self.courseList = [self.reader initializeDataFrompList];
    
    // It is better to use this format for NSLog (constant string literal)
    //NSLog(@"< %@", self.courseList.allKeys);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *courses = self.courseList[@"courses"];
    return [courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //
    // TODO: Fix this, just stubbed in
    //
    
    //NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSArray *courses = self.courseList[@"courses"];
    NSLog(@"%@", indexPath);
    NSDictionary *thisCourse = courses[0];
    //NSString *thisCourseNumber = [[NSString alloc] initWithFormat:@"%@:%@", [thisCourse valueForKey:@"subject"], [thisCourse valueForKey:@"number"]];
    
    cell.textLabel.text = [[thisCourse valueForKey:@"name"] description];
    //cell.detailTextLabel.text = [[thisCourse valueForKey:@"presentationStyle"] description];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//        
//        NSError *error = nil;
//        if (![context save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//#ifdef DEBUG
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//#endif
//            abort();
//        }
//    }
//}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}

#pragma mark Detail View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showCourse"]){
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [[segue destinationViewController] setCourseItem:object];
//    }
}

@end
