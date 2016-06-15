//
//  CooksBasedOnLocationTableViewController.m
//  Etbo5ly
//
//  Created by ITI on 5/27/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "CooksBasedOnLocationTableViewController.h"

@interface CooksBasedOnLocationTableViewController ()

@end

@implementation CooksBasedOnLocationTableViewController
{
    BOOL calculateScrollPosition;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self.navigationController setNavigationBarHidden:YES];
    self.title=_orderAddress;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _cooksOnLocation.count;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
//
//    cell.textLabel.text=[[_cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"name"];
//
//    
//    return cell;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath function");
    
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text=[[_cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"name"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[_cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[_cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"imageURL"]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    cell.detailTextLabel.text=[[_cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"address"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    Cook *selectedCook = [[Cook alloc] initWithInfo ];
    
    selectedCook.name = [[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"name"];
    selectedCook.userId = [[[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue ];
    selectedCook.address = [[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"address"];
    selectedCook.email = [[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"email"];
    selectedCook.phone = [[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"phone"];
    selectedCook.regionID = [[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"regionId"];
    selectedCook.registerationDate =[NSDate dateWithTimeIntervalSince1970:([[[_cooksOnLocation objectAtIndex:indexPath.row ] valueForKey:@"registerationDate"] longLongValue]/1000.0)];
    selectedCook.imageURL = [NSString stringWithFormat: @"%@%@",[[ _cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"], [[ _cooksOnLocation objectAtIndex:indexPath.row] objectForKey:@"imageURL"]];
    NSLog(@"coookkk %@",selectedCook.imageURL);
    selectedCook.longitude = [[[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"longitude"] integerValue];
    selectedCook.latitude = [[[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"latitude"] integerValue];
    selectedCook.startWorkingHours=[NSDate dateWithTimeIntervalSince1970:([[[_cooksOnLocation objectAtIndex:indexPath.row ] valueForKey:@"startWorkingHours"] longLongValue]/1000.0)];
    selectedCook.endWorkingHours =[NSDate dateWithTimeIntervalSince1970:([[[_cooksOnLocation objectAtIndex:indexPath.row ] valueForKey:@"endWorkingHours"] longLongValue]/1000.0)];
    selectedCook.password =[[_cooksOnLocation objectAtIndex:indexPath.row] valueForKey:@"password"];
    UIStoryboard *storyboard = self.navigationController.storyboard;
    CookDetailedViewController *cookDetailedViewController=[storyboard instantiateViewControllerWithIdentifier:@"detailedCookViewController"];
    [cookDetailedViewController setDetailedCook:selectedCook];
    [self.navigationController pushViewController:cookDetailedViewController animated:YES];
    
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
    
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
}
-(void)viewDidAppear:(BOOL)animated
{
   // calculateScrollPosition=YES;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollingggg");
//    if (calculateScrollPosition==YES) {
//        NSLog(@"ha %f",scrollView.contentOffset.y);
//        if (scrollView.contentOffset.y<0) {
//            [self.navigationController setNavigationBarHidden:NO];
//        }
//        else
//        {
//            [self.navigationController setNavigationBarHidden:YES];
//        }
//    }
//}

//-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    NSLog(@"topp");
//    return YES;
//}
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


@end
