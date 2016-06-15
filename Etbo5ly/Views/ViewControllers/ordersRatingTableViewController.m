//
//  ordersRatingTableViewController.m
//  Etbo5ly
//
//  Created by ITI on 6/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "ordersRatingTableViewController.h"
#import "BasketTableViewController.h"


@interface ordersRatingTableViewController ()

@end

@implementation ordersRatingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    networkDelegate=self;
    
    userDBFunctions=[[UserDAO alloc] initWithManagedObject];
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
    cookDBFunctions=[[CookDAO alloc] initWithManagedObject];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    
    int userID=[userDBFunctions selectRegisteredUser].userId;
    [self getAllNotRatedOrders:userID];
}
-(void) getAllNotRatedOrders : (int) userID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    NSDictionary *parameters=[[NSDictionary alloc] init];
    parameters = @{@"format": @"json"};
    [manager GET:[URLS getNonRatingOrder:userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [URLS getNonRatingOrder:userID] );
        _allNonRatedOrder=[[NSMutableArray alloc] initWithArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //handle with failure
        NSLog(@"Error: %@", error);
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%d",_allNonRatedOrder.count);
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_allNonRatedOrder.count==0) {
        return 1;
    }
    else
    {
        return _allNonRatedOrder.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    
    if (_allNonRatedOrder.count==0) {
        cell= [tableView dequeueReusableCellWithIdentifier:@"noOrders" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
        HCSStarRatingView *ratingStars=(HCSStarRatingView *)[cell viewWithTag:2];
        int cookID=[[[_allNonRatedOrder objectAtIndex:indexPath.row] objectForKey:@"cookName"] integerValue];
        NSString * imageCook=[cookDBFunctions selectCookBasedOnID:cookID].imageURL;
        UIImageView * cookImage=(UIImageView*)[cell viewWithTag:1];
        UILabel * cookNameLabel=(UILabel*)[cell viewWithTag:3];
        UILabel * orderPrice=(UILabel*)[cell viewWithTag:4];
        UILabel * orderDate=(UILabel*)[cell viewWithTag:5];
        ratingStars.value=0;
        cookNameLabel.text=[[_allNonRatedOrder objectAtIndex:indexPath.row] objectForKey:@"cookName"];
        NSString *orderPriceString=[[_allNonRatedOrder objectAtIndex:indexPath.row] objectForKey:@"totalPrice"];
        NSDate * dateOrder=[NSDate dateWithTimeIntervalSince1970:([[[_allNonRatedOrder objectAtIndex:indexPath.row] objectForKey:@"orderTime"] doubleValue]/1000.0)];
        orderPrice.text=[NSString stringWithFormat:@"EGP %@",orderPriceString];
        orderDate.text=[NSString stringWithFormat:@"%@",dateOrder];
        [cookImage sd_setImageWithURL:[NSURL URLWithString:imageCook] placeholderImage:[UIImage imageNamed:@"icon_etbokhlyPlaceholder.png"]];
        return cell;
    }
}


-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    NSLog(@"helloooo");
}
- (IBAction)changeRatingValue:(id)sender {
    HCSStarRatingView *orderRating=(HCSStarRatingView *)sender;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        //orderRating.value;
        NSLog(@"b%d",indexPath.row);
    }
    NSLog(@"%@",[[_allNonRatedOrder objectAtIndex:indexPath.row] valueForKey:@"cookRating"]);
    
    NSMutableDictionary *orderToBeRate=[[_allNonRatedOrder objectAtIndex:indexPath.row] mutableCopy];
    [orderToBeRate setObject:[NSNumber numberWithFloat:orderRating.value] forKey:@"cookRating"];
    NSLog(@"%@",orderToBeRate);
    [userRequestedServices rateOrder:orderToBeRate];
    [_allNonRatedOrder removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    
    // NSLog(@"%f%d",noha.value,b.section);
}
@end
