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
//    if(allMeals==nil)
//    {
//        allMeals=[]
//    }
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
//    listItemHeader.text=[(MenuItems *)[allMeals objectAtIndex:indexPath.row] ] ;
//    listItemSubHeader.text=[(MenuItems *)[_cooks objectAtIndex:indexPath.row] address] ;
//    [listItemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",[(Cook*)[ _cooks objectAtIndex:indexPath.row] imageURL]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    
    return cell;
    
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return [(MenuItems*)[[allMeals objectAtIndex:section] objectAtIndex:0]cookName];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect screenRectangle=[[UIScreen mainScreen] applicationFrame];
    UIView *footerView=[[UIView alloc]init];
    UIButton *checkOutbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkOutbutton setTitle:@"Add to other" forState:UIControlStateNormal];
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
//    "userByCustomerId": 1,
//    "customerName": "AlJazayeerly",
//    "userByCookId": 2,
//    "cookName": "Menna",
//    "location": "ITI",
//    "duration": 45,
//    "customerRating": null,
//    "orderComment": null,
//    "cookRating": null,
//    "cookComment": null,
//    "type": "1",
//    "longitude": 31.021249,
//    "latitude": 30.071572,
//    "addressDetails": "Information Technology Institute",
//    "regionId": 3
    _orderJSONParameters=@{@"userByCustomerId":@"1",@"customerName":@"AlJazayeerly",@"userByCookId":@"Menna",@"location":@"ITI",@"duration":@"45",@"customerRating":@"",@"orderComment":@"",@"type":@"",@"longitude":@"",@"latitude":@"",@"addressDetails":@""};
    NSArray *ab=@[@{@"no":@"b"}];
 //   [_orderJSONParameters setObject:@"2" forKeyedSubscript:@"userByCustomerId"];
    NSLog(@"%@",ab);
    NSLog(@"buttonn%d",sender.tag);
    NSLog(@"%@",[allMeals objectAtIndex:sender.tag]);
    
}

@end
