//
//  AddItemViewController.m
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong Liu on 1/10/14.
//  Copyright (c) 2014 Tong. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation AddItemViewController

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
    [self.textView setDelegate:self];
    [self.textField setDelegate:self];
    
    self.textView.text = @"Content";
    self.textView.textColor = [UIColor lightGrayColor];
    
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
        self.userTopic = [[UserTopic alloc] init];
        self.userTopic.topicName = self.textField.text;
        NSString* enteredContent = [self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
        self.userTopic.topicContent = enteredContent;
    }
}

// textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textView becomeFirstResponder];
    self.textView.text = @"";
    return YES;
}


// textview thingies

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Content"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Content";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

@end
