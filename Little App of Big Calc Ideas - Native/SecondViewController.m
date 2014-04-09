//
//  SecondViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/19/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "UserTopic.h"
#import "AddItemViewController.h"

@interface SecondViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation SecondViewController

- (IBAction)returnToList:(UIStoryboardSegue *)segue
{
    AddItemViewController* source = [segue sourceViewController];
    UserTopic* newTopic = source.userTopic;
    if (newTopic != nil)
    {
        // create html file
        NSString* htmlTop = @"<!DOCTYPE html><html><head><meta charset=\"utf-8\" /><meta name=\"format-detection\" content=\"telephone=no\" /><meta name=\"viewport\" content=\"user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi\" /><link rel=\"stylesheet\" href=\"http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css\" /><link rel=\"stylesheet\" href=\"styles.css\"/><style>.ui-page { background: white; }.ui-footer { background: white; }</style><script src=\"http://code.jquery.com/jquery-1.9.1.min.js\"></script><script src=\"http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js\"></script><title>Little App of Big Calc Ideas</title></head><body><div data-role=\"page\"><div data-role=\"content\">";
        NSString* htmlBottom = @"</div></div><script type=\"text/javascript\" src=\"cordova-2.7.0.js\"></script><script type=\"text/javascript\" src=\"js/index.js\"></script></body></html>";
        NSString *html = [NSString stringWithFormat:@"%@%@%@", htmlTop, newTopic.topicContent, htmlBottom];
        
        // build the path where you're going to save the HTML
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filenamePart = [NSString stringWithFormat:@"%@.html", newTopic.topicName];
        NSString *filename = [docsFolder stringByAppendingPathComponent:filenamePart];
        
        // save the NSString that contains the HTML to a file
        NSError *error;
        [html writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:&error];
        
        // add to arraysicle (plist)
        NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:plistPath])
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
        }

        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSMutableArray* myArray = [plistRoot objectForKey:self.title];
        if (myArray == nil || [myArray isKindOfClass:[NSString class]])
        {
            myArray = [[NSMutableArray alloc] init];
        }
        [myArray addObject:newTopic.topicName];
        [plistRoot setObject:myArray forKey:self.title];
        
        [plistRoot writeToFile:plistPath atomically:YES];
        
        // add to tableview
        [_objects addObject:newTopic.topicName];
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addToObjects:(NSString*)category
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSMutableArray* sections;
    
    // Pre-Calc Knowledge
    if ([category isEqualToString:@"Pre-Calc Knowledge"])
        sections = [NSMutableArray arrayWithObjects: @"Trigonometric Identities", @"Rectangular-Polar Conversions", nil];
    
    // Limits and Continuity
    else if ([category isEqualToString:@"Limits and Continuity"])
        sections = [NSMutableArray arrayWithObjects: @"Limits", @"Asymptotic Behavior", @"Formal Definition of a Limit", @"Continuity", @"Continuity of Trig Functions", @"Squeeze Theorem", nil];
    
    // Derivatives
    else if ([category isEqualToString:@"Derivatives"])
        sections = [NSMutableArray arrayWithObjects: @"Slope of a Secant Line", @"Slope of a Tangent Line", @"Rates of Change", @"Differentiation Rules", @"Product and Quotient Rules", @"Higher Order Derivatives", @"Derivatives of Trig Functions", @"Chain Rule", @"Rates of Change of Parametrics", @"Rates of Change of Polar Graphs", nil];
    
    // Applications of Derivatives
    else if ([category isEqualToString:@"Applications of Derivatives"])
        sections = [NSMutableArray arrayWithObjects: @"Implicit Differentiation", @"Differentiation of Inverses", @"Related Rates", @"Local Linear Approximations", @"L'Hopital's Rule", @"Analyzing Graphs", @"1st Derivative Test", @"2nd Derivative Test", @"Graphing Functions", @"Multiplicity", @"Absolute Extrema", @"Rectilinear Motion", @"Mean Value (Rolle's) Theorem", nil];
    
    // Integration and Antidifferentiation
    else if ([category isEqualToString:@"The Fundamental Theorem"])
        sections = [NSMutableArray arrayWithObjects: @"Indefinite Integrals", @"Definite Integrals", @"FTC", nil];
    
    // Approximating Integrals
    else if ([category isEqualToString:@"Approximating Integrals"])
        sections = [NSMutableArray arrayWithObjects: @"Left Hand Rule", @"Right Hand Rule", @"Midpoint Rule", @"Trapezoid Rule", @"Simpson's Rule", @"Riemann Sums", nil];
    
    // Integration Techniques
    else if ([category isEqualToString:@"Integration Techniques"])
        sections = [NSMutableArray arrayWithObjects: @"U-Substitution", @"Integrals of Trig Functions", @"Integrals of Inverse Trig", @"Integration by Parts", @"Partial Fractions", nil];
    
    // Applications of Integrals
    else if ([category isEqualToString:@"Applications of Integrals"])
        sections = [NSMutableArray arrayWithObjects: @"Rectilinear Motion Using Integration", @"Mean Value Theorem for Integrals", @"Logarithms Defined by Integrals", @"Area Between Two Curves", @"Volumes Through Disks or Washers", @"Volumes Through Cross Sections", @"Volumes Through Shell Method", @"Area of Regions Defined by Parametrics", @"Area of Polar Curves", @"Arc Length", @"Work", @"Differential Equations", @"Rates of Growth", @"Euler's Method", nil];
    
    // Series
    else if ([category isEqualToString:@"Series"])
        sections = [NSMutableArray arrayWithObjects: @"Sequences and Series", @"Monotonic Sequences", @"Infinite Series", @"Convergence Tests", @"Alternating Series", @"MacLaurin and Taylor Polynomials", @"Power Series", nil];
    
    // Do Stuff
    [_objects removeAllObjects];
    [_objects addObjectsFromArray:sections];    
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
    NSArray* arrayFromPlist = [plistRoot objectForKey:self.title];
    if ([arrayFromPlist isKindOfClass:[NSArray class]])
    {
        [_objects addObjectsFromArray:arrayFromPlist];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self addToObjects:self.title];
    [self addFromPlist];
        
    // add that young extra nav button item
    NSArray* originalSections = [NSArray arrayWithObjects: @"Pre-Calc Knowledge", @"Limits and Continuity", @"Derivatives", @"Applications of Derivatives", @"The Fundamental Theorem", @"Approximating Integrals", @"Integration Techniques", @"Applications of Integrals", @"Series", nil];
    
    if (![originalSections containsObject:self.title])
    {
        SEL deleteButtonSelector = @selector(deleteButtonPressed:);
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:deleteButtonSelector];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:deleteButton, self.addButton, nil];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)
    {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [[self navigationItem] setBackBarButtonItem:backButton];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.objects removeAllObjects];
    [self addToObjects:self.title];
    [self addFromPlist];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString* title = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController* detailViewController = (DetailViewController *)[segue destinationViewController];
        NSIndexPath* path = [self.tableView indexPathForCell:sender];
        detailViewController.title = [_objects objectAtIndex:path.row];
        [detailViewController setCategory:self.title];
        [detailViewController setComingFromDelete:NO];
    }
}

// delete button and action sheet

- (IBAction)deleteButtonPressed:(id)sender
{
    NSString *destructiveTitle = @"Delete Category";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}


- (IBAction)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Delete Category"])
    {
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        if (![[plistRoot objectForKey:self.title] isKindOfClass:[NSString class]])
        {
            NSMutableArray* arrayFromPlist = [plistRoot objectForKey:self.title];
            for (int i = 0; i < arrayFromPlist.count; i++)
            {
                NSString *filenamePart = [NSString stringWithFormat:@"%@.html", [arrayFromPlist objectAtIndex:i]];
                NSString* filename = [docsFolder stringByAppendingPathComponent:filenamePart];
                NSError *error;
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:filename error:&error];
            }
        }
        
        
        [plistRoot removeObjectForKey:self.title];
        [plistRoot writeToFile: plistPath atomically:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
