//
//  DetailViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/14/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import "DetailViewController.h"
#import "EditItemViewController.h"
#import "SecondViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize webView;

- (IBAction)returnToDetail:(UIStoryboardSegue *)segue
{
    [self loadWebView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEdit"])
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        EditItemViewController *editItemViewController = (EditItemViewController *)navController.topViewController;
        [editItemViewController setWhereforeItCame:self.title];
        [editItemViewController setCategory:self.category];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadWebView];
}

- (void)loadWebView
{
    NSString* topic = self.title;
    self.initialTopics = [NSMutableArray arrayWithObjects: @"Trigonometric Identities", @"Rectangular-Polar Conversions", @"Limits", @"Asymptotic Behavior", @"Formal Definition of a Limit", @"Continuity", @"Continuity of Trig Functions", @"Squeeze Theorem", @"Slope of a Secant Line", @"Slope of a Tangent Line", @"Rates of Change", @"Differentiation Rules", @"Product and Quotient Rules", @"Higher Order Derivatives", @"Derivatives of Trig Functions", @"Chain Rule", @"Rates of Change of Parametrics", @"Rates of Change of Polar Graphs", @"Implicit Differentiation", @"Differentiation of Inverses", @"Related Rates", @"Local Linear Approximations", @"L'Hopital's Rule", @"Analyzing Graphs", @"1st Derivative Test", @"2nd Derivative Test", @"Graphing Functions", @"Multiplicity", @"Absolute Extrema", @"Rectilinear Motion", @"Mean Value (Rolle's) Theorem", @"Indefinite Integrals", @"Definite Integrals", @"FTC", @"Left Hand Rule", @"Right Hand Rule", @"Midpoint Rule", @"Trapezoid Rule", @"Simpson's Rule", @"Riemann Sums", @"U-Substitution", @"Integrals of Trig Functions", @"Integrals of Inverse Trig", @"Integration by Parts", @"Partial Fractions", @"Rectilinear Motion Using Integration", @"Mean Value Theorem for Integrals", @"Logarithms Defined by Integrals", @"Area Between Two Curves", @"Volumes Through Disks or Washers", @"Volumes Through Cross Sections", @"Volumes Through Shell Method", @"Area of Regions Defined by Parametrics", @"Area of Polar Curves", @"Arc Length", @"Work", @"Differential Equations", @"Rates of Growth", @"Euler's Method", @"Sequences and Series", @"Monotonic Sequences", @"Infinite Series", @"Convergence Tests", @"Alternating Series", @"MacLaurin and Taylor Polynomials", @"Power Series", nil];
    NSString* path;
    
    NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *plistPath = [docsFolder stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary* plistRoot = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSMutableDictionary* edited = [plistRoot objectForKey:@"this_has_been_edited_tong_said_So"];
    
    if ([self.initialTopics indexOfObject:topic] != NSNotFound && [edited objectForKey:self.title] == nil)
    {
        path = [[NSBundle mainBundle] pathForResource:topic ofType:@"html" inDirectory:@"topics"];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    }
    else
    {
        path = [[NSBundle mainBundle] pathForResource:topic ofType:@"html" inDirectory:@"Documents"];
        NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filenamePart = [NSString stringWithFormat:@"%@.html", topic];
        NSString *filename = [docsFolder stringByAppendingPathComponent:filenamePart];
        NSURL *url = [NSURL fileURLWithPath:filename];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (self.comingFromDelete)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [webView reload];
}

@end
