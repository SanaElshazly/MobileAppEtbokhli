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
    [_tableViewData reloadData];
    NSLog(@"%@",[allBasketMeals allValues]);
    allMeals=[allBasketMeals allValues];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"basket %d",allBasketMeals.count);
    return allBasketMeals.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"mealls %d",[[allMeals objectAtIndex:section] count]);
    return [[allMeals objectAtIndex:section] count];
    
}
+(void)addMealToBasket:(MenuItems *)newMeal
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID1 = @"CellIdentifier1";
    static NSString *cellID2=@"CellIdentifier2";
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        }
        cell.textLabel.text=@"Nohnoh";
         return cell;
    }
    else
    {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if(!cell2)
        {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID2];
        }
        cell2.textLabel.text=@"Monmon";
        return cell2;
    }
    
   
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
    }
    else
    {
        [[allBasketMeals valueForKey:cookName] addObject:newMeal];
    }

}


@end
