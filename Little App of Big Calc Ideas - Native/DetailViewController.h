//
//  DetailViewController.h
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/14/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property NSArray* initialTopics;
@property NSString* category;
@property NSString* deletedIdea;
@property BOOL comingFromDelete;

@end

