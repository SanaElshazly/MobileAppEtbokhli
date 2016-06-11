//
//  CookDetailedViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/10/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cook.h"
#import "CookServices.h"
#import "CategoryItemsTableViewController.h"
#import "UIImageView+WebCache.h"

@interface CookDetailedViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>
{
    int cookIDforCategory;
    int categoryIDforItems;
    
//    NSMutableArray * cookCategories;
    CookServices *cooksRequestedCategories;
}
@property (strong,nonatomic) Cook *detailedCook;
@property (strong,nonatomic) NSMutableArray * cookCategories;
@property (strong,nonatomic) NSMutableArray * cookCategoriesID;

@property (strong, nonatomic) IBOutlet UIImageView *cookProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *cookNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *cookAddressLbl;
@property (strong, nonatomic) IBOutlet UILabel *cookWorkingHrsLbl;
@property (strong, nonatomic) IBOutlet UITableView *cookMenuTableView;

@end
