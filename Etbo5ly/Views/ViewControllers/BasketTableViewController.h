//
//  BasketTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/2/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItems.h"

static NSMutableArray *allCookIDInBasket;
static int numberOfCooksInBasket;
@interface BasketTableViewController : UITableViewController
@property NSMutableArray * allBasketMeals;
+(void) addMealToBasket : (MenuItems *) newMeal;
+(void) addCookToBasket : (int) CookID;
-(void ) addCookMealstoBasket : (NSString*) cookName setCookMealsOrder : (MenuItems *) newMeal;
@end
