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
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self getAllNotRatedOrders:1];
}
-(void) getAllNotRatedOrders : (int) userID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    NSDictionary *parameters=[[NSDictionary alloc] init];
    parameters = @{@"format": @"json"};
    [manager GET:[URLS getNonRatingOrder:userID] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
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
    // Return the number of sections.
    NSLog(@"%d",_allNonRatedOrder.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return _allNonRatedOrder.count;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"hello");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    HCSStarRatingView *ratingStars=(HCSStarRatingView *)[cell viewWithTag:1];
    ratingStars.value=0;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"gelo");
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
    [[_allNonRatedOrder objectAtIndex:indexPath.row] setValue: [NSNumber numberWithInt:orderRating.value] forKey:@"customerRating"];
    [userRequestedServices rateOrder:[_allNonRatedOrder objectAtIndex:indexPath.row]];
    [_allNonRatedOrder removeObjectAtIndex:indexPath.row];
    //[self.tableView reloadData];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    
   // NSLog(@"%f%d",noha.value,b.section);
}
@end
