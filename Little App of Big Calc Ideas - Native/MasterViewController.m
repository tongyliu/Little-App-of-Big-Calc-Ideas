//
//  MasterViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/14/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SecondViewController.h"
#import "AddCategoryViewController.h"
#import "AboutViewController.h"

@interface MasterViewController () {
    NSMutableArray* _objects;
    NSMutableArray *_allTopics;
    NSMutableArray* _searchObjects;
    NSString* _category;
    NSArray* sections;
    BOOL isSearching;
}
@end

@implementation MasterViewController

@synthesize tableView = _tableView;
@synthesize searchBar;
@synthesize searchDisplayController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [searchDisplayController setDelegate:self];
    [searchBar setDelegate:self];

	// Do any additional setup after loading the view, typically from a nib.
    NSString* back;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1];
        self.navigationController.toolbar.translucent = NO;
        back = @"";
    }
    else
    {
        [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1]];
        self.navigationController.toolbar.tintColor = [UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1];
        back = @"Back";
    }

    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    if (!_allTopics)
    {
        [self addToAllTopics];
    }

    sections = [NSArray arrayWithObjects: @"Pre-Calc Knowledge", @"Limits and Continuity", @"Derivatives", @"Applications of Derivatives", @"The Fundamental Theorem", @"Approximating Integrals", @"Integration Techniques", @"Applications of Integrals", @"Series", nil];
    [_objects addObjectsFromArray:(sections)];
    [self addFromPlist];
    
    self.title = @"Little App of Big Calc Ideas";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:back style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    isSearching = NO;
    _searchObjects = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [_tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];
    [_allTopics removeAllObjects];
    [self addToAllTopics];
    [_objects removeAllObjects];
    [self reloadCategoryData];
    [_tableView reloadData];
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)reloadCategoryData
{
    [_objects addObjectsFromArray:(sections)];
    [self addFromPlist];
}

// add to all topics
- (void)addToAllTopics
{
    _allTopics = [NSMutableArray arrayWithObjects: @"Trigonometric Identities", @"Rectangular-Polar Conversions", @"Limits", @"Asymptotic Behavior", @"Formal Definition of a Limit", @"Continuity", @"Continuity of Trig Functions", @"Squeeze Theorem", @"Slope of a Secant Line", @"Slope of a Tangent Line", @"Rates of Change", @"Differentiation Rules", @"Product and Quotient Rules", @"Higher Order Derivatives", @"Derivatives of Trig Functions", @"Chain Rule", @"Rates of Change of Parametrics", @"Rates of Change of Polar Graphs", @"Implicit Differentiation", @"Differentiation of Inverses", @"Related Rates", @"Local Linear Approximations", @"L'Hopital's Rule", @"Analyzing Graphs", @"1st Derivative Test", @"2nd Derivative Test", @"Graphing Functions", @"Multiplicity", @"Absolute Extrema", @"Rectilinear Motion", @"Mean Value (Rolle's) Theorem", @"Indefinite Integrals", @"Definite Integrals", @"FTC", @"Left Hand Rule", @"Right Hand Rule", @"Midpoint Rule", @"Trapezoid Rule", @"Simpson's Rule", @"Riemann Sums", @"U-Substitution", @"Integrals of Trig Functions", @"Integrals of Inverse Trig", @"Integration by Parts", @"Partial Fractions", @"Rectilinear Motion Using Integration", @"Mean Value Theorem for Integrals", @"Logarithms Defined by Integrals", @"Area Between Two Curves", @"Volumes Through Disks or Washers", @"Volumes Through Cross Sections", @"Volumes Through Shell Method", @"Area of Regions Defined by Parametrics", @"Area of Polar Curves", @"Arc Length", @"Work", @"Differential Equations", @"Rates of Growth", @"Euler's Method", @"Sequences and Series", @"Monotonic Sequences", @"Infinite Series", @"Convergence Tests", @"Alternating Series", @"MacLaurin and Taylor Polynomials", @"Power Series", nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path])
    {
        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        for (id key in plistRoot)
        {
            if (![key isEqual:@"this_has_been_edited_tong_said_So"] && [[plistRoot objectForKey:key] isKindOfClass:[NSArray class]])
            {
                NSArray *plistArray = [plistRoot objectForKey:key];
                [_allTopics addObjectsFromArray:plistArray];
            }
        }
    }
}

- (void)addFromPlist
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }
    
    NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    for (id key in plistRoot)
    {
        NSString* keyString = key;
        if (![key isEqualToString:@"this_has_been_edited_tong_said_So"] && ![sections containsObject:keyString])
        {
            [_objects addObject:keyString];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        return [_searchObjects count];
    }
    else return [_objects count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString* title;
    if (isSearching) {
        title = [_searchObjects objectAtIndex:indexPath.row];
    }
    else {
        title = [_objects objectAtIndex:indexPath.row];
        
        // add image :D
        if ([sections containsObject:title])
        {
            NSString *imageName = [title stringByAppendingString:@".png"];
            cell.imageView.image = [UIImage imageNamed:imageName];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"user.png"];
        }
    }
    cell.textLabel.text = title;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearching) {
        [self performSegueWithIdentifier:@"searchShowDetail" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"showCategoryListing" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCategoryListing"]) {
        SecondViewController* secondViewController = (SecondViewController *)[segue destinationViewController];
        NSIndexPath* path = [_tableView indexPathForSelectedRow];
        secondViewController.title = [_objects objectAtIndex:path.row];
    }
    else if ([[segue identifier] isEqualToString:@"searchShowDetail"] && isSearching) {
        DetailViewController* detailViewController = (DetailViewController *)[segue destinationViewController];
        NSIndexPath* path = [searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        detailViewController.title = [_searchObjects objectAtIndex:path.row];
        [searchDisplayController setActive:NO animated:NO];
    }
}

#pragma mark - Search Bar

- (void)filterListForSearchText:(NSString *)searchText
{
    [_searchObjects removeAllObjects];
    
    for (NSString *topic in _allTopics) {
        NSRange nameRange = [topic rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [_searchObjects addObject:topic];
        }
    }
    
    [_tableView reloadData];
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {   
    isSearching = YES;
    [_tableView reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    isSearching = NO;
    [_tableView reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterListForSearchText:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterListForSearchText:[self.searchDisplayController.searchBar text]];     
    return YES;
}

/* End of search thingy */

- (IBAction)returnToList:(UIStoryboardSegue *)segue
{
    AddCategoryViewController* source = [segue sourceViewController];
    if ([source isKindOfClass:[AboutViewController class]])
    {
        return;
    }
    NSString* newCategory = source.enteredCategory;
    if (newCategory != nil)
    {
        NSString* newCategoryName;
        
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSError *error;
        
        // add to arraysicle (plist)
        NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:plistPath])
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
        }
        
        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSMutableArray* myArray = [plistRoot objectForKey:newCategory];
        NSString* filler = @"Blank Category";
        if (myArray == nil)
        {
            [plistRoot setObject:filler forKey:newCategory];
            newCategoryName = newCategory;
        }
        else
        {
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            NSString* extra_before = @" Copy ";
            NSString* extra = [extra_before stringByAppendingString:dateString];
            NSString* newCategoryWithDate = [newCategory stringByAppendingString:extra];
            
            [plistRoot setObject:filler forKey:newCategoryWithDate];
            newCategoryName = newCategoryWithDate;
        }
        
        [plistRoot writeToFile: plistPath atomically:YES];
        [_objects addObject:newCategoryName];
        [_tableView reloadData];
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
    
@end
