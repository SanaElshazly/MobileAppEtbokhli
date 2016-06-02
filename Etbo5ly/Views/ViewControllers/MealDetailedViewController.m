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

    self.navigationController.navigationItem.title=@"hna";
    NSLog(@"hna");
}
-(void)viewDidAppear:(BOOL)animated
{
    _detailedMealName.text=[_detailedMeal nameEn];
    [_detailedMealImage sd_setImageWithURL:[NSURL URLWithString:[_detailedMeal imageURL]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    [_detailedMealDescription setText:[_detailedMeal descriptionEn]];
    _detailedMealPrice.text=[NSString stringWithFormat:@"%f",[_detailedMeal price] ];
    _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    _totalItemPrice.text=[NSString stringWithFormat:@"%f",([_detailedMealPrice.text floatValue] * quantity)];
    NSLog(@"%@",[_detailedMeal nameEn]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addMealQuantity:(id)sender {
    quantity++;
    _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    _totalItemPrice.text=[NSString stringWithFormat:@"%f",([_detailedMealPrice.text floatValue] * quantity)];
}

- (IBAction)subtractMealQuantity:(id)sender {
    if (quantity<=1) {
        quantity=1;
        _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
        _totalItemPrice.text=[NSString stringWithFormat:@"%f",([_detailedMealPrice.text floatValue] * quantity)];
    }
    else
    {
        quantity--;
        _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
        _totalItemPrice.text=[NSString stringWithFormat:@"%f",([_detailedMealPrice.text floatValue] * quantity)];
    }
}
@end
