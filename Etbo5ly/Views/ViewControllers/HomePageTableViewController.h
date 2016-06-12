//
//  HomePageTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 5/22/16s.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Etbo5lyNetworkDelegate.h"
#import "Etbo5lyNetworkManager.h"
#import "URLS.h"
#import "MealsServices.h"
#import "CookServices.h"
#import "UIImageView+WebCache.h" 
#import "CookDAO.h"
#import "AFNetworking.h"
#import "MenuItemDAO.h"
#import "MealDetailedViewController.h"
#import "CookDetailedViewController.h"
#import "locationServices.h"

@interface HomePageTableViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
   // NSArray *cooks;
    MealsServices *mealsRequestedService;
    CookServices *cooksRequestedMeals;
    CookDAO *cookRequestedDBFunctions;
    MenuItemDAO *mealsRequestedDBFunctions;
    NSArray *searchResults;
    UIRefreshControl *refreshControl;
}
@property (strong,nonatomic) NSMutableArray * cooks;
@property (strong,nonatomic) NSMutableArray *meals;
@property (strong, nonatomic) IBOutlet UISegmentedControl *menuOptions;
@property (strong, nonatomic) IBOutlet UITableView *dataTableView;
@property BOOL  isUserReachable;

- (IBAction)changeValueOfSegmentedController:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *sreachBarOutlet;

-(void) checkConnectivity;

@end
