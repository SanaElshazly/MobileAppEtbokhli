//
//  MealDetailedViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 6/1/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "MealDetailedViewController.h"

@interface MealDetailedViewController ()

@end

@implementation MealDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    quantity=1;
    self.title=_detailedMeal.nameEn ;
  //  [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:_detailedMeal.nameEn];
    NSLog(@"hna");
}
-(void)viewDidAppear:(BOOL)animated
{
    _detailedMealName.text=[_detailedMeal nameEn];
    [_detailedMealImage sd_setImageWithURL:[NSURL URLWithString:[_detailedMeal imageURL]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    [_detailedMealDescription setText:[_detailedMeal descriptionEn]];
    _detailedMealPrice.text=[NSString stringWithFormat:@"EGP %d",(int)[_detailedMeal price] ];
    _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    _totalItemPrice.text=[NSString stringWithFormat:@"EGP %d",(int)(_detailedMeal.price * quantity)];
    _menu_item_rating.value=[_detailedMeal itemRate];
    _menu_item_rating.userInteractionEnabled=NO;
    NSLog(@"%@",[_detailedMeal nameEn]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addMealQuantity:(id)sender {
    quantity++;
    _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    _totalItemPrice.text=[NSString stringWithFormat:@"EGP %d",(int)([_detailedMeal price] * quantity)];
}

- (IBAction)subtractMealQuantity:(id)sender {
    if (quantity<=1) {
        quantity=1;
        _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
        _totalItemPrice.text=[NSString stringWithFormat:@"EGP %d",(int)([_detailedMeal price] * quantity)];
    }
    else
    {
        quantity--;
        _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
        _totalItemPrice.text=[NSString stringWithFormat:@"EGP %d",(int)([_detailedMeal price ]* quantity)];
    }
}

- (IBAction)addMealToItem:(id)sender {
    _detailedMeal.quantity=quantity;
    NSLog(@"%d",_detailedMeal.quantity);
    [BasketTableViewController addCookMealstoBasket:[_detailedMeal cookName] setCookMealsOrder:_detailedMeal];
    [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:@""];
    [self .navigationController popToRootViewControllerAnimated:YES];
}
@end
