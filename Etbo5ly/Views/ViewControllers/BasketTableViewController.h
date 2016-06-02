//
//  BasketTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/2/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItems.h"
static NSMutableArray * allBasketMeals;
@interface BasketTableViewController : UITableViewController

+(void) addMealToBasket : (MenuItems *) newMeal;

@end
