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
   
    NSLog(@"%@",[allBasketMeals allValues]);
    networkDelegate=self;
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
    allMeals=[allBasketMeals allValues];
     NSLog(@"meaaals%@",allMeals);
    if (_orderJSONParameters==nil) {
        _orderJSONParameters=[[NSMutableDictionary alloc] init];
    }
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *totalPricePerCook = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, tableView.frame.size.width, 18)];
    UILabel *sectionTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 5, tableView.frame.size.width, 18)];
    [totalPricePerCook setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *sectionTotalPrice =[NSString stringWithFormat:@"%f",[orderDetails orderTotalPrice] ];
    NSString * sectionTitle=[(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
    [sectionTitleLabel setText:sectionTitle];
    [totalPricePerCook setText:sectionTotalPrice];
    [view addSubview:sectionTitleLabel];
    [view addSubview:totalPricePerCook];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
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
+(void)addCookToBasket:(int)CookID
{
    for (NSNumber *num in allCookIDInBasket) {
        if ([allCookIDInBasket containsObject:num]) {
            numberOfCooksInBasket++;
        }
    }
}
+(void)addCookMealstoBasket:(NSString *)cookName setCookMealsOrder:(MenuItems *)newMeal
{
    if (allBasketMeals==nil) {
        allBasketMeals=[[NSMutableDictionary alloc] init];
    }

    NSLog(@"%@",allBasketMeals);
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
-(void) checkOut : (UIButton*) sender
{
    NSArray *cookOrder=[allMeals objectAtIndex:sender.tag];
    NSString *allOrderDetails;
    NSMutableArray *cookOrderArray=[[NSMutableArray alloc] init];
    orderDetails=[[Order alloc] initWithInfo];
    for (MenuItems *ittem in cookOrder) {
        orderDetails.orderTotalPrice=[ittem price]+[orderDetails orderTotalPrice];
        NSLog(@"%f",[orderDetails orderTotalPrice]);
        [cookOrderArray addObject:[MenuItems convertObjectToJSON:ittem]];
    }_orderJSONParameters=@{@"userByCustomerId":@1,@"customerName":@"AlJazayeerly",@"userByCookId":@2,@"cookName":@"menna",@"location":@"ITI",@"duration":@45,@"customerRating":@1,@"orderComment":@"",@"cookRating":@1,@"cookComment":@"good",@"type":@1,@"longitude":@31.07,@"latitude":@30.5,@"addressDetails":@"",@"regionId":@3,@"totalPrice":@900,@"orderDetails":cookOrderArray};
    NSLog(@"%@",_orderJSONParameters);
    allOrderDetails=[self convertParametersToJSON:_orderJSONParameters];
    NSLog(@"%@",allOrderDetails);
    [userRequestedServices createOrder:_orderJSONParameters];

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
  //  [_orderJSONParameters delete:];
}
-(void)handleWithFailure:(NSError *)error
{
    NSLog(@"ERRRROOR");
}
@end
