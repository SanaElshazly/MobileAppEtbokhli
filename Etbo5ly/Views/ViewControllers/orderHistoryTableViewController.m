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
    registeredUser=[userDBFunctions selectRegisteredUser];
    [self getAllOrders:registeredUser.userId];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return _allUserOrders.count;
}
//-(void)handle:(id)dataRetreived :(NSString *)serviceName
//{
//    if ([serviceName isEqualToString:@"allOrders"]) {
//        _allUserOrders=[[NSMutableArray alloc] initWithArray:dataRetreived];
//    }
//}
-(void) getAllOrders : (int) userID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    NSDictionary *parameters=[[NSDictionary alloc] init];
    parameters = @{@"format": @"json"};
    [manager GET:[URLS getAllOrderHistory:userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        _allUserOrders=[[NSMutableArray alloc] initWithArray:responseObject];
        
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
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
    return cell;
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
