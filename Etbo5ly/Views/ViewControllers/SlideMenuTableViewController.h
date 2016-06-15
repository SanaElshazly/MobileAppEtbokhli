//
//  SlideMenuTableViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "SCLAlertView.h"
@interface SlideMenuTableViewController : UITableViewController
{
    UserDAO *userRequestedFunctions;
    User *registeredUser;
}
@property (strong, nonatomic) IBOutlet UITableView *slideMenuTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *signInCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *profileCell;
@property (strong, nonatomic) IBOutlet UITableView *moreTableView;

@property (strong, nonatomic) IBOutlet UITableViewCell *orderRatingCell;
@end
