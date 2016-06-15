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
    self.mealDetailsTableView.rowHeight = UITableViewAutomaticDimension;
  //  [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:_detailedMeal.nameEn];
    NSLog(@"hna");
}
-(void)viewDidAppear:(BOOL)animated
{
    _detailedMealName.text=[_detailedMeal nameEn];
    [_detailedMealImage sd_setImageWithURL:[NSURL URLWithString:[_detailedMeal imageURL]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    [_detailedMealDescription setText:[_detailedMeal descriptionEn]];
    _detailedMealDescription.numberOfLines = 0; //will wrap text in new line
    [ _detailedMealDescription sizeToFit];
    _detailedMealPrice.text=[NSString stringWithFormat:@"EGP %d",(int)[_detailedMeal price] ];
    _MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    _totalItemPrice.text=[NSString stringWithFormat:@"EGP %d",(int)(_detailedMeal.price * quantity)];
    _menu_item_rating.value=[_detailedMeal itemRate];
    _menu_item_rating.userInteractionEnabled=NO;
    NSLog(@"%@",[_detailedMeal nameEn]);
    [self.mealDetailsTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[super tableView: tableView cellForRowAtIndexPath:indexPath];
    float descHeight;
    if (cell==_descriptionCell) {
        descHeight=[self getHeightForText:_detailedMealDescription.text withFont:[UIFont systemFontOfSize:17.0] andWidth:1.0f];
        return descHeight;
    }
     return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 40.0f);
    return height;
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
