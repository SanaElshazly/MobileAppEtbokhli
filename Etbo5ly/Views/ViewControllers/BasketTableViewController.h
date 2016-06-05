//
//  BasketTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/2/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItems.h"
#import "UserServices.h"
#import "Order.h"
#import "UIImageView+WebCache.h" 
static NSMutableArray *allCookIDInBasket;
static NSMutableDictionary * allBasketMeals;;
static int numberOfCooksInBasket;
@interface BasketTableViewController : UITableViewController <Etbo5lyNetworkDelegate>
{
    UserServices *userRequestedServices;
    Order * orderDetails;
}
+(void) addMealToBasket : (MenuItems *) newMeal;
+(void) addCookToBasket : (int) CookID;
+(void ) addCookMealstoBasket : (NSString*) cookName setCookMealsOrder : (MenuItems *) newMeal;
-(NSString *) convertParametersToJSON : (NSDictionary *) cookOrder;
@property NSDictionary *orderJSONParameters;
@property (strong, nonatomic) IBOutlet UITableView *tableViewData;
@end
