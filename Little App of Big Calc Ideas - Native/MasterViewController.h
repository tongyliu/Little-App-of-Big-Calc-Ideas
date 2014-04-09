//
//  MasterViewController.h
//  Little App of Big Calc Ideas - Native
//
//  Created by Tong  on 6/14/13.
//  Copyright (c) 2013 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
