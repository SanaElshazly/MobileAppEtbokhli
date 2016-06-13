//
//  BasketTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 6/2/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "BasketTableViewController.h"

@interface BasketTableViewController ()

@end
//static NSMutableArray *allMeals;
@implementation BasketTableViewController
{
   NSArray *allMeals;
    NSArray *allCooksNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    userDBFunctions=[[UserDAO alloc] initWithManagedObject];
    [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
    NSLog(@"%@",[allBasketMeals allValues]);
    networkDelegate=self;
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
    
     NSLog(@"meaaals%@",allMeals);
    if (_orderJSONParameters==nil) {
        _orderJSONParameters=[[NSMutableDictionary alloc] init];
    }
    isBasketController=NO;
    
     [_tableViewData reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    allMeals=[allBasketMeals allValues];
  //  NSLog(@"basket %d",allBasketMeals.count);
    return allMeals.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"mealls %lu",(unsigned long)[[allMeals objectAtIndex:section] count]);
    return [[allMeals objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    UIImageView *listItemImage=(UIImageView *)[cell viewWithTag:1];
    UILabel *listItemHeader=(UILabel *)[cell viewWithTag:2];
    UILabel *listItemSubHeader=(UILabel *)[cell viewWithTag:3];
    UILabel *quantityLabel=(UILabel*)[cell viewWithTag:4];
    quantityLabel.text=[NSString stringWithFormat:@"%d * ",[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] quantity]];
   listItemHeader.text=[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] nameEn];
    listItemSubHeader.text=[NSString stringWithFormat:@"%2f",[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] price]];
    [listItemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] imageURL]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    
    
    return cell;
    
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return [(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    orderDetails=[[Order alloc] initWithInfo];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    UILabel *totalPricePerCook = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, tableView.frame.size.width, 20)];
    UILabel *sectionTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, tableView.frame.size.width, 20)];
    [totalPricePerCook setFont:[UIFont boldSystemFontOfSize:16]];
    
    for (MenuItems *menuItemInOrder in [allMeals objectAtIndex:section]) {
        orderDetails.orderTotalPrice=([menuItemInOrder price]*[menuItemInOrder quantity])+[orderDetails orderTotalPrice];
        NSLog(@"%f",[orderDetails orderTotalPrice]);
    }
    NSString *sectionTotalPrice =[NSString stringWithFormat:@"%f",[orderDetails orderTotalPrice] ];
    NSString * sectionTitle=[(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
    
    
    sectionTitleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    sectionTitleLabel.textColor = [UIColor orangeColor];
    
    [sectionTitleLabel setText:sectionTitle];
    [totalPricePerCook setText:sectionTotalPrice];
    [view addSubview:sectionTitleLabel];
    [view addSubview:totalPricePerCook];
    view.layer.borderColor = [UIColor brownColor].CGColor;
    view.layer.borderWidth = 1.0;

    [view setBackgroundColor:[UIColor whiteColor]];//colorWithRed:1.00 green:0.90 blue:0.76 alpha:1.0]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 41;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]init];
    UIButton *checkOutbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkOutbutton setTitle:@"Check Out" forState:UIControlStateNormal];
    [checkOutbutton setBackgroundColor:[UIColor orangeColor]];
    checkOutbutton.tag=section;
    [checkOutbutton addTarget:self action:@selector(checkOut:) forControlEvents:UIControlEventTouchUpInside];
    
    checkOutbutton.layer.cornerRadius = 10;
    
    [checkOutbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
    checkOutbutton.frame=CGRectMake(95, 0, 191, 30); //set some large width to ur titl
    [footerView addSubview:checkOutbutton];
    return footerView;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSLog(@" deleted meal %@ ",[(MenuItems*)[[allMeals objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] nameEn]);
        
        NSMutableArray *deletedItem= [allBasketMeals objectForKey:[(MenuItems*)[[allMeals objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] cookName]];
        if (deletedItem.count>1) {
            NSString *deletedName=[(MenuItems*)[[allMeals objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] cookName];
            [[allBasketMeals objectForKey:deletedName] removeObjectAtIndex:indexPath.row];
            NSLog(@"%@",allBasketMeals);
            
        }
        else
        {
            NSString *deletedName=[(MenuItems*)[[allMeals objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] cookName];
            [allBasketMeals removeObjectForKey:deletedName];
            [allBasketMeals removeObjectForKey:deletedName];
            NSLog(@"%@",allBasketMeals);
            
        }
        
        [self.tableView reloadData];
        
    }
}
+(void)addCookMealstoBasket:(NSString *)cookName setCookMealsOrder:(MenuItems *)newMeal
{
    if (allBasketMeals==nil) {
        allBasketMeals=[[NSMutableDictionary alloc] init];
    }
    
    
    NSLog(@"%@",[allBasketMeals valueForKey:cookName]);
    if (![allBasketMeals valueForKey:cookName]) {
        NSMutableArray * newCookMeals=[[NSMutableArray alloc] init];
        [newCookMeals addObject:newMeal];
        [allBasketMeals setObject:newCookMeals forKey:cookName];
    }
    else
    {
        for (MenuItems *menuItemObj in [allBasketMeals objectForKey:cookName]) {
            if (menuItemObj.itemId==newMeal.itemId) {
                menuItemObj.quantity=menuItemObj.quantity+1;
                NSLog(@"meaaals%@",allBasketMeals);
            }
            else
            {
                [[allBasketMeals valueForKey:cookName] addObject:newMeal];
            }
        }
        
    }
    NSLog(@"%@",allBasketMeals);
    NSLog(@"%@",[allBasketMeals valueForKey:cookName]);

}
+(BOOL)changeValue
{
    return isBasketController;
}
+(NSMutableDictionary*) getall
{
    return allBasketMeals;
}
-(void) checkOut : (UIButton*) sender
{
    UserDAO *requestedUserDBFunvtions=[[UserDAO alloc] initWithManagedObject];
    NSArray *cookOrder=[allMeals objectAtIndex:sender.tag];
    NSLog(@"yarab b2a%@",[(MenuItems*)[[allMeals objectAtIndex:sender.tag] objectAtIndex:0]cookName]);
    orderDetails.cookName=[(MenuItems*)[[allMeals objectAtIndex:sender.tag] objectAtIndex:0]cookName];
    orderDetails.cookID=[(MenuItems*)[[allMeals objectAtIndex:sender.tag] objectAtIndex:0]cookID];
    NSLog(@"%@",orderDetails);
 //   orderDetails.cookID=[[allMeals objectAtIndex:sender.tag] cookID];
    //NSLog(@"%@",registeredUser.email);
    registeredUser=[userDBFunctions selectRegisteredUser];
    if (registeredUser.email==(id) [NSNull null]||registeredUser.email.length==0) {
        NSLog(@"Error");
        isBasketController=YES;
        UIStoryboard *storyboard=self.navigationController.storyboard;
        LoginViewController *loginViewController=[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [loginViewController setOrderToCheckedOut:cookOrder];
        [loginViewController setOrderCookDetails:orderDetails];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    else
    {
        UIStoryboard *storyboard=self.navigationController.storyboard;
        orderAddressDetailsTableViewController * orderAddress=[storyboard instantiateViewControllerWithIdentifier:@"orderAddress"];
        [orderAddress setOrderDetails:cookOrder];
        [orderAddress setOrderCookDetails:orderDetails];
        [self.navigationController pushViewController:orderAddress animated:YES];

    }
    mealsInOrder=[[MenuItems alloc] init];
    mealsInOrder=[allMeals objectAtIndex:sender.tag];
}

+(User*)getUserInfo
{
    return registeredUser;
}
-(NSString *)convertParametersToJSON:(NSDictionary *)cookOrder
{
    NSData *json;
    NSError *error = nil;
    NSString *jsonString;
    if ([NSJSONSerialization isValidJSONObject:_orderJSONParameters])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:_orderJSONParameters options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON: %@", jsonString);
        }
    }
    return jsonString;
}
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    NSLog(@"SUCESSSS");
   // [allBasketMeals removeObjectForKey:[orderDetails cookName]];
}
-(void)handleWithFailure:(NSError *)error
{
    NSLog(@"ERRRROOR");
}
- (IBAction)editBasket:(id)sender {
}
@end
