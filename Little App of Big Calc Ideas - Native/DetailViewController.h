//
//  DetailViewController.h
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/14/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
