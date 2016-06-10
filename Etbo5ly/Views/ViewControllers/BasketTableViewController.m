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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarItem.badgeValue=nil;
    NSLog(@"%@",[allBasketMeals allValues]);
    networkDelegate=self;
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
    allMeals=[allBasketMeals allValues];
    allCookIDInBasket=[allBasketMeals allKeys];
     NSLog(@"meaaals%@",allMeals);
    if (_orderJSONParameters==nil) {
        _orderJSONParameters=[[NSMutableDictionary alloc] init];
    }
    isBasketController=NO;
    [[self tabBarItem] setBadgeValue:@"42"];
     [_tableViewData reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  //  NSLog(@"basket %d",allBasketMeals.count);
    return allMeals.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"mealls %d",[[allMeals objectAtIndex:section] count]);
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
   listItemHeader.text=[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] nameEn];
   listItemSubHeader.text=[NSString stringWithFormat:@"%f",[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] price]];
    
    [listItemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",[(MenuItems *)[[allMeals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] imageURL]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    
    
    return cell;
    
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return [(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    orderDetails=[[Order alloc] initWithInfo];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *totalPricePerCook = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, tableView.frame.size.width, 18)];
    UILabel *sectionTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, tableView.frame.size.width, 18)];
    [totalPricePerCook setFont:[UIFont boldSystemFontOfSize:12]];
    for (MenuItems *menuItemInOrder in [allMeals objectAtIndex:section]) {
        orderDetails.orderTotalPrice=[menuItemInOrder price]+[orderDetails orderTotalPrice];
        NSLog(@"%f",[orderDetails orderTotalPrice]);
    }
    NSString *sectionTotalPrice =[NSString stringWithFormat:@"%f",[orderDetails orderTotalPrice] ];
    NSString * sectionTitle=[(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
    [sectionTitleLabel setText:sectionTitle];
    [totalPricePerCook setText:sectionTotalPrice];
    [view addSubview:sectionTitleLabel];
    [view addSubview:totalPricePerCook];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect screenRectangle=[[UIScreen mainScreen] applicationFrame];
    UIView *footerView=[[UIView alloc]init];
    UIButton *checkOutbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkOutbutton setTitle:@"Check Out" forState:UIControlStateNormal];
    [checkOutbutton setBackgroundColor:[UIColor orangeColor]];
    checkOutbutton.tag=section;
    [checkOutbutton addTarget:self action:@selector(checkOut:) forControlEvents:UIControlEventTouchUpInside];
    
    [checkOutbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
    checkOutbutton.frame=CGRectMake(0, 0, screenRectangle.size.width, 30); //set some large width to ur titl
    [footerView addSubview:checkOutbutton];
    return footerView;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
+(void)addCookMealstoBasket:(NSString *)cookName setCookMealsOrder:(MenuItems *)newMeal
{
    if (allBasketMeals==nil) {
        allBasketMeals=[[NSMutableDictionary alloc] init];
    }

    NSLog(@"meaaals%@",allBasketMeals);
    NSLog(@"%@",[allBasketMeals valueForKey:cookName]);
    if (![allBasketMeals valueForKey:cookName]) {
        NSMutableArray * newCookMeals=[[NSMutableArray alloc] init];
        [newCookMeals addObject:newMeal];
        [allBasketMeals setObject:newCookMeals forKey:cookName];
//        [allMeals addObject:newCookMeals];
    }
    else
    {
        [[allBasketMeals valueForKey:cookName] addObject:newMeal];
    }
    NSLog(@"%@",allBasketMeals);
    NSLog(@"%@",[allBasketMeals valueForKey:cookName]);

}
+(BOOL)changeValue
{
    isBasketController=YES;
    return isBasketController;
}
-(void) checkOut : (UIButton*) sender
{
    UserDAO *requestedUserDBFunvtions=[[UserDAO alloc] initWithManagedObject];
    NSArray *cookOrder=[allMeals objectAtIndex:sender.tag];
    NSMutableArray *cookOrderArray=[[NSMutableArray alloc] init];
    NSLog(@"yarab b2a%@",[(MenuItems*)[[allMeals objectAtIndex:sender.tag] objectAtIndex:0]cookName]);
    orderDetails.cookName=[(MenuItems*)[[allMeals objectAtIndex:sender.tag] objectAtIndex:0]cookName];
    NSLog(@"%@",orderDetails);
 //   orderDetails.cookID=[[allMeals objectAtIndex:sender.tag] cookID];

    
   
    registeredUser=[requestedUserDBFunvtions selectRegisteredUser];
    //NSLog(@"%@",registeredUser.email);
    if (registeredUser.email==(id) [NSNull null]||registeredUser.email.length==0) {
        NSLog(@"Error");
        NSLog(@"%hhd",[BasketTableViewController changeValue]);
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
