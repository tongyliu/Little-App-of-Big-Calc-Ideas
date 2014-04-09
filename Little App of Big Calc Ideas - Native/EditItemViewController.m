//
//  EditItemViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong Liu on 1/11/14.
//  Copyright (c) 2014 Tong. All rights reserved.
//

#import "EditItemViewController.h"
#import "DetailViewController.h"

@interface EditItemViewController () <UITableViewDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end


@implementation EditItemViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1];
    }
    
    [self.textView setDelegate:self];
    
    self.textView.text = @"Enter text to be appended";
    self.textView.textColor = [UIColor lightGrayColor];
    
    NSArray* initialTopics = [NSArray arrayWithObjects: @"Trigonometric Identities", @"Rectangular-Polar Conversions", @"Limits", @"Asymptotic Behavior", @"Formal Definition of a Limit", @"Continuity", @"Continuity of Trig Functions", @"Squeeze Theorem", @"Slope of a Secant Line", @"Slope of a Tangent Line", @"Rates of Change", @"Differentiation Rules", @"Product and Quotient Rules", @"Higher Order Derivatives", @"Derivatives of Trig Functions", @"Chain Rule", @"Rates of Change of Parametrics", @"Rates of Change of Polar Graphs", @"Implicit Differentiation", @"Differentiation of Inverses", @"Related Rates", @"Local Linear Approximations", @"L'Hopital's Rule", @"Analyzing Graphs", @"1st Derivative Test", @"2nd Derivative Test", @"Graphing Functions", @"Multiplicity", @"Absolute Extrema", @"Rectilinear Motion", @"Mean Value (Rolle's) Theorem", @"Indefinite Integrals", @"Definite Integrals", @"FTC", @"Left Hand Rule", @"Right Hand Rule", @"Midpoint Rule", @"Trapezoid Rule", @"Simpson's Rule", @"Riemann Sums", @"U-Substitution", @"Integrals of Trig Functions", @"Integrals of Inverse Trig", @"Integration by Parts", @"Partial Fractions", @"Rectilinear Motion Using Integration", @"Mean Value Theorem for Integrals", @"Logarithms Defined by Integrals", @"Area Between Two Curves", @"Volumes Through Disks or Washers", @"Volumes Through Cross Sections", @"Volumes Through Shell Method", @"Area of Regions Defined by Parametrics", @"Area of Polar Curves", @"Arc Length", @"Work", @"Differential Equations", @"Rates of Growth", @"Euler's Method", @"Sequences and Series", @"Monotonic Sequences", @"Infinite Series", @"Convergence Tests", @"Alternating Series", @"MacLaurin and Taylor Polynomials", @"Power Series", nil];
    
    if ([initialTopics indexOfObject:self.whereforeItCame] != NSNotFound)
    {
        [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.deleteButton setUserInteractionEnabled:NO];
    }
    
    NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (plistRoot != nil)
    {
        NSMutableDictionary* edited = [plistRoot objectForKey:@"this_has_been_edited_tong_said_So"];
        if ([edited objectForKey:self.whereforeItCame] != nil)
        {
            NSString* previousText = [edited objectForKey:self.whereforeItCame];
            if (![previousText isEqualToString:@""])
            {
                self.textView.text = [previousText stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton)
        return;
    else
    {
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filenamePart = [NSString stringWithFormat:@"%@.html", self.whereforeItCame];
        NSString *filename = [docsFolder stringByAppendingPathComponent:filenamePart];
        
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:filename])
        {
            NSString *bundleHTML = [[NSBundle mainBundle] pathForResource:self.whereforeItCame ofType:@"html" inDirectory:@"topics"];
            [fileManager copyItemAtPath:bundleHTML toPath:filename error:&error];
            
            NSString* folderPath = [docsFolder stringByAppendingPathComponent:@"eqn"];
            if (![fileManager fileExistsAtPath:folderPath])
            {
                NSArray *bundlePngs = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"topics/eqn"];
                NSArray *bundleGifs = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"topics/eqn"];
                [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:&error];
                for (NSString* pic in bundlePngs)
                {
                    NSString* picName = [pic lastPathComponent];
                    NSString *destination = [folderPath stringByAppendingPathComponent:picName];
                    [fileManager copyItemAtPath:pic toPath:destination error:&error];
                }
                for (NSString* pic in bundleGifs)
                {
                    NSString* picName = [pic lastPathComponent];
                    NSString *destination = [folderPath stringByAppendingPathComponent:picName];
                    [fileManager copyItemAtPath:pic toPath:destination error:&error];
                }
            }
        }
        
        NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSMutableDictionary *edited = [plistRoot objectForKey:@"this_has_been_edited_tong_said_So"];
        if (edited == nil)
        {
            edited = [[NSMutableDictionary alloc] init];
        }
        
        NSString *contents = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    
        int previousLength;
        NSString* previousText = [edited objectForKey:self.whereforeItCame];
        if (previousText == nil)
            previousLength = 0;
        else
            previousLength = (int) previousText.length;
        
        NSArray* splitContents = [contents componentsSeparatedByString:@"</div>"];
        NSString* secondPart = @"</em></div></div><script type=\"text/javascript\" src=\"cordova-2.7.0.js\"></script><script type=\"text/javascript\" src=\"js/index.js\"></script></body></html>";

        NSString* formatString = @"<br/><br/><em>";
        int formatLength = 19;
        contents = [splitContents objectAtIndex:0];
        if (previousText != nil)
        {
            contents = [contents substringToIndex:(contents.length - previousLength - formatLength)];
        }
        contents = [contents stringByAppendingString:formatString];
        NSString *enteredText = [self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
        contents = [contents stringByAppendingString:enteredText];
        contents = [contents stringByAppendingString:secondPart];
        
        [contents writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        [edited setObject:enteredText forKey:self.whereforeItCame];
        [plistRoot setObject:edited forKey:@"this_has_been_edited_tong_said_So"];
        [plistRoot writeToFile:plistPath atomically:YES];
        
    }
}

// textview thingies

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter text to be appended"]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter text to be appended";
    }
    textView.textColor = [UIColor lightGrayColor];

    [textView resignFirstResponder];
}

// delete button

- (IBAction)deleteButtonPressed:(id)sender
{
    NSString *destructiveTitle = @"Delete Idea";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

// action sheet

- (IBAction)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Delete Idea"])
    {
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filenamePart = [NSString stringWithFormat:@"%@.html", self.whereforeItCame];
        NSString *filename = [docsFolder stringByAppendingPathComponent:filenamePart];
        
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filename error:&error];
        
        NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
        NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        if (self.category != nil)
        {
            NSMutableArray* myArray = [plistRoot objectForKey:self.category];
            
            [myArray removeObject:self.whereforeItCame];
            [plistRoot setObject:myArray forKey:self.category];
        }
        
        else
        {
            id myKey;
            for (id key in plistRoot)
            {
                if (![key isEqualToString:@"this_has_been_edited_tong_said_So"])
                {
                    for (NSString *idea in [plistRoot objectForKey:key])
                    {
                        if ([idea isEqualToString:self.whereforeItCame])
                        {
                            myKey = key;
                        }
                    }
                }
            }
            NSMutableArray* myArray = [plistRoot objectForKey:myKey];
            [myArray removeObject:self.whereforeItCame];
            [plistRoot setObject:myArray forKey:myKey];
        }
        
        NSMutableDictionary* edited = [plistRoot objectForKey:@"this_has_been_edited_tong_said_So"];
        if ([edited objectForKey:self.whereforeItCame] != nil)
        {
            [edited removeObjectForKey:self.whereforeItCame];
            [plistRoot setObject:edited forKey:@"this_has_been_edited_tong_said_So"];
        }
        
        [plistRoot writeToFile: plistPath atomically:YES];
        
        UINavigationController* navController = (UINavigationController *)self.presentingViewController;
        DetailViewController *detailViewController = (DetailViewController *)navController.topViewController;
        [detailViewController setComingFromDelete:YES];
        [detailViewController setDeletedIdea:self.whereforeItCame];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}




@end
