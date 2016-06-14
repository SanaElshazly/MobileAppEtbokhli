//
//  orderHistoryTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 6/12/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "orderHistoryTableViewController.h"

@interface orderHistoryTableViewController ()

@end

@implementation orderHistoryTableViewController
{
    UIAlertView *alert;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _allUserOrders=[[NSMutableArray alloc]init];
    userDBFunctions=[[UserDAO alloc] initWithManagedObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    _allUserOrders=[[NSMutableArray alloc] init];
    registeredUser=[userDBFunctions selectRegisteredUser];
    if (registeredUser.userId!=0) {
        [self getAllOrders:registeredUser.userId];
    }
    else
    {
         alert=[[UIAlertView alloc] initWithTitle:@"Login" message:@" to view your oeders" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        [alert show];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self.tabBarController setSelectedIndex:0];
    }
    else
    {
        UIStoryboard *storyboard=self.navigationController.storyboard;
        LoginViewController *loginViewController=[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_allUserOrders.count==0) {
        return 1;
    }
    else
    {
        return _allUserOrders.count;
    }
}
-(void) getAllOrders : (int) userID
{
    [self viewActivityProgress];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    NSDictionary *parameters=[[NSDictionary alloc] init];
    parameters = @{@"format": @"json"};
    [manager GET:[URLS getAllOrderHistory:userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        _allUserOrders=[[NSMutableArray alloc] initWithArray:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [orderHistoryProgress hide:YES];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //[self handleWithFailure:error];
        NSLog(@"Error: %@", error);
    }];
    
}
-(void)handleWithFailure:(NSError *)error
{
    NSLog(@"errroooorrrr");
}
-(void) viewActivityProgress
{
    orderHistoryProgress=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    orderHistoryProgress.labelColor=[UIColor orangeColor];
    orderHistoryProgress.tintColor=[UIColor grayColor];
    orderHistoryProgress.labelText=@"Loading";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    
    if (_allUserOrders.count==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"noResults" forIndexPath:indexPath];
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
        HCSStarRatingView *ratingStars=(HCSStarRatingView *)[cell viewWithTag:2];
        [ratingStars setUserInteractionEnabled:NO];
        NSLog(@"%@",[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"customerRating"]);
        ratingStars.value=[[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"customerRating"] integerValue];
        
        int cookID=[[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"userByCookId"] integerValue];
        
        NSString * imageCook=[cookDBFunctions selectCookBasedOnID:cookID].imageURL;
        UIImageView * cookImage=(UIImageView*)[cell viewWithTag:1];
        UILabel * cookNameLabel=(UILabel*)[cell viewWithTag:3];
        UILabel * orderPrice=(UILabel*)[cell viewWithTag:4];
        UILabel * orderDate=(UILabel*)[cell viewWithTag:5];
        cookNameLabel.text=[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"cookName"];
        NSString *orderPriceString=[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"totalPrice"];
        NSDate * dateOrder=[NSDate dateWithTimeIntervalSince1970:([[[_allUserOrders objectAtIndex:indexPath.row] objectForKey:@"orderTime"] doubleValue]/1000.0)];
        orderPrice.text=[NSString stringWithFormat:@"EGP %@",orderPriceString];
        orderDate.text=[NSString stringWithFormat:@"%@",dateOrder];
        [cookImage sd_setImageWithURL:[NSURL URLWithString:imageCook] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard * storyboard=self.navigationController.storyboard;
    orderDetailsTableViewController *orderDetailsView=[storyboard instantiateViewControllerWithIdentifier:@"orderHistoryDetails"];
    NSLog(@"%@",[_allUserOrders objectAtIndex:indexPath.row]);
    [orderDetailsView setOrderHistoryDetails:[_allUserOrders objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:orderDetailsView animated:YES];
}
@end
