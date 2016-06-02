//
//  MealDetailedViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/1/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItems.h"
#import "UIImageView+WebCache.h" 
@interface MealDetailedViewController : UIViewController
{
    int quantity;
}
@property (strong,nonatomic) MenuItems *detailedMeal;
@property (strong, nonatomic) IBOutlet UIImageView *detailedMealImage;
@property (strong, nonatomic) IBOutlet UILabel *detailedMealName;
@property (strong, nonatomic) IBOutlet UILabel *detailedMealDescription;
@property (strong, nonatomic) IBOutlet UILabel *detailedMealPrice;
- (IBAction)addMealQuantity:(id)sender;
- (IBAction)subtractMealQuantity:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *MealQuantity;
@property (strong, nonatomic) IBOutlet UILabel *totalItemPrice;

@end
