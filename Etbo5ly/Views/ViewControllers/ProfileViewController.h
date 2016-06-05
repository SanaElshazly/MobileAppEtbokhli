//
//  ProfileViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *usernameLbl;

@property (strong, nonatomic) IBOutlet UIImageView *usernameImg;

@property (strong, nonatomic) IBOutlet UISegmentedControl *profileSegmentedController;
@property (strong, nonatomic) IBOutlet UITableView *profileTableView;

@end
