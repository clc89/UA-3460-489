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

// TODO: Switch to using the managed object subclass
// (instead of valueForKey)

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
    
    self.filteredCourseArray = [NSMutableArray arrayWithCapacity:[[self.fetchedResultsController fetchedObjects] count]];
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"%lu", (unsigned long)[self.filteredCourseArray count]);
        return [self.filteredCourseArray count];
    } else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [sectionInfo numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"here");
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ( cell == nil ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell
        
        NSArray *allItems = [[NSArray alloc] init];
        allItems = [self.fetchedResultsController fetchedObjects];
        
        NSManagedObject *object = [allItems objectAtIndex:indexPath.row];
        NSString *thisCourseNumber = [[NSString alloc] initWithFormat:@"%@:%@", [object valueForKey:@"subject"], [object valueForKey:@"number"]];
        
        cell.textLabel.text = [[object valueForKey:@"name"] description];
        cell.detailTextLabel.text = thisCourseNumber;
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
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
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSLog(@"new");
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            
            NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            [[segue destinationViewController] setCourseItem:object];
            
            NSString *destinationTitle = [[self.filteredCourseArray objectAtIndex:[indexPath row]] name];
            [[segue destinationViewController] setTitle:destinationTitle];
        } else {
            NSLog(@"old");
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            [[segue destinationViewController] setCourseItem:object];
        }
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *thisCourseNumber = [[NSString alloc] initWithFormat:@"%@:%@", [object valueForKey:@"subject"], [object valueForKey:@"number"]];
    
    cell.textLabel.text = [[object valueForKey:@"name"] description];
    cell.detailTextLabel.text = thisCourseNumber;
    
    if ([[object valueForKey:@"taken"]  isEqual:@YES]) {
        cell.imageView.image = [UIImage imageNamed:@"check"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"x"];
    }
}

#pragma mark - Observers

- (void)courseContextProvided:(NSNotification *) notification {
    self.managedObjectContext = [notification object];
    
    // No data? Grab some from the seed plist
    if ([self.tableView numberOfRowsInSection:0] <= 0) {
        CourseReader *reader = [[CourseReader alloc] init];
        NSDictionary *courseList = [[NSDictionary alloc] init];
        courseList = [reader initializeDataFrompList];
        NSArray *courses = courseList[@"courses"];
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        for (NSDictionary *course in courses) {
            NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
            
            [newManagedObject setValue:course[@"area"] forKey:@"area"];
            [newManagedObject setValue:course[@"credits"] forKey:@"credits"];
            [newManagedObject setValue:course[@"description"] forKey:@"desc"];
            [newManagedObject setValue:course[@"name"] forKey:@"name"];
            [newManagedObject setValue:course[@"number"] forKey:@"number"];
            [newManagedObject setValue:NO forKey:@"required"];
            [newManagedObject setValue:course[@"subject"] forKey:@"subject"];
            [newManagedObject setValue:NO forKey:@"taken"];
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

#pragma mark Content Filtering

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSArray *allItems = [[NSArray alloc] init];
    allItems = [self.fetchedResultsController fetchedObjects];
    
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredCourseArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredCourseArray = [NSMutableArray arrayWithArray:[allItems filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
