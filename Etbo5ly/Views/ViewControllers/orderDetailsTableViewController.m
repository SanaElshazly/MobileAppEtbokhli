//
//  orderDetailsTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 6/13/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "orderDetailsTableViewController.h"

@interface orderDetailsTableViewController ()

@end

@implementation orderDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_orderHistoryDetails);
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else
    {
        NSLog(@"%@",[_orderHistoryDetails valueForKey:@"orderDetails"]);
        NSLog(@"%d",[[_orderHistoryDetails valueForKey:@"orderDetails"] count]);
        
        return [[_orderHistoryDetails valueForKey:@"orderDetails"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell ;
    
    if (indexPath.section==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"staticCellOrder" forIndexPath:indexPath];
    }
    else
    {
        int quantity=[[[[_orderHistoryDetails valueForKey:@"orderDetails"] objectAtIndex:indexPath.row] valueForKey:@"quantity"] integerValue];
        cell=[tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
        cell.textLabel.text=[NSString stringWithFormat:@"%d x %@",quantity,[[[_orderHistoryDetails valueForKey:@"orderDetails"] objectAtIndex:indexPath.row] valueForKey:@"menuItemsNameEn"]];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"EGP %d",[[[[_orderHistoryDetails valueForKey:@"orderDetails"] objectAtIndex:indexPath.row] valueForKey:@"menuItemsPrice"] integerValue]];
    }
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeader=@"";
    if (section!=0) {
        sectionHeader=[NSString stringWithFormat:@"Total : %d EGP",[[_orderHistoryDetails valueForKey:@"totalPrice"] integerValue]];
    }
    return sectionHeader;
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
