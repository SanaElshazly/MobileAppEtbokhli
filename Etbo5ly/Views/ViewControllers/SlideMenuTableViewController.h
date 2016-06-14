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
}
@property (strong, nonatomic) IBOutlet UITableView *slideMenuTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *signInCell;

@end
