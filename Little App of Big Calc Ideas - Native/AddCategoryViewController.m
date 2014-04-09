//
//  AddCategoryViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong on 1/19/14.
//  Copyright (c) 2014 Tong. All rights reserved.
//

#import "AddCategoryViewController.h"

@interface AddCategoryViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddCategoryViewController

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
    [self.textField setDelegate:self];
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(31/255.0) green:(47/255.0) blue:(63/255.0) alpha:1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton)
        return;
    
    if (self.textField.text.length > 0)
    {
        self.enteredCategory = self.textField.text;
    }
}

// textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
