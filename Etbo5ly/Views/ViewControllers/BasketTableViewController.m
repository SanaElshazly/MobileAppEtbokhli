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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
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
-(void)addCookMealstoBasket:(NSString *)cookName setCookMealsOrder:(MenuItems *)newMeal
{
    if (![_allBasketMeals valueForKey:cookName]) {
        NSMutableArray * newCookMeals=[[NSMutableArray alloc] init];
        [newCookMeals addObject:newMeal];
        [_allBasketMeals addObject:newCookMeals];
    }
    else
    {
        [[_allBasketMeals valueForKey:cookName] addObject:newMeal];
    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
