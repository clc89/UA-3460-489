//
//  ISTSecondViewController.m
//  iStudent
//
//  Created by Christopher Stoll on 11/8/13.
//  Copyright (c) 2013 University of Akron. All rights reserved.
//

#import "ISTCourseMasterViewController.h"
#import "ISTCourseDetailViewController.h"

@interface ISTCourseMasterViewController ()

@end

@implementation ISTCourseMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //
    // Go to the AppDelegate and tell it to send us some context
    // (I doubt that this is the right pattern to use here)
    //
    // listen for notifications to get core data context
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(courseContextProvided:) name:@"courseContextProvided" object:nil];
    // notify the delagate we are looking for context
    [[NSNotificationCenter defaultCenter] postNotificationName:@"provideCourseContext" object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"courseDetailSegue"]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setCourseItem:object];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
#ifdef DEBUG
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *thisCourseNumber = [[NSString alloc] initWithFormat:@"%@:%@", [object valueForKey:@"subject"], [object valueForKey:@"number"]];
    
    cell.textLabel.text = [[object valueForKey:@"name"] description];
    cell.detailTextLabel.text = thisCourseNumber;
}


#pragma mark - Observers

- (void)courseContextProvided:(NSNotification *) notification {
    NSLog(@"%@", [notification object]);
    self.managedObjectContext = [notification object];
    
    if ([self.tableView numberOfRowsInSection:0] <= 0) {
        // You must allocate memory and initialize these first -- Stoll
        CourseReader *reader = [[CourseReader alloc] init];
        NSDictionary *courseList = [[NSDictionary alloc] init];
        courseList = [reader initializeDataFrompList];
        NSArray *courses = courseList[@"courses"];
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        NSLog(@"%@", context);
        for (NSDictionary *course in courses) {
            NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
            
            [newManagedObject setValue:course[@"subject"] forKey:@"subject"];
            [newManagedObject setValue:course[@"number"] forKey:@"number"];
            [newManagedObject setValue:course[@"name"] forKey:@"name"];
            [newManagedObject setValue:course[@"subject"] forKey:@"subject"];
            [newManagedObject setValue:course[@"credits"] forKey:@"credits"];
            [newManagedObject setValue:course[@"description"] forKey:@"desc"];
        }
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
