//
//  orderAddressTableViewController.m
//  Etbo5ly
//
//  Created by ITI on 6/7/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "orderAddressTableViewController.h"

@interface orderAddressTableViewController ()

@end

@implementation orderAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (allCities==nil) {
        LocationPageViewController *locationView=[[LocationPageViewController alloc] init];
        [locationView getAllRegionsAndCities ];
    }
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
-(void) showCityPickerCell
{
    self.dataPickerViewIsShowingCities=YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.citiesPickerView.hidden=NO;
    self.citiesPickerView.alpha=0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.citiesPickerView.alpha=1.0f;
    }];
}
-(void) hideDataPickerCell
{
    self.dataPickerViewIsShowingCities=NO;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        self.citiesPickerView.alpha=0.0f;
    }
                     completion:^(BOOL fininshed){
                         self.citiesPickerView.hidden=YES;
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 && indexPath.row==0 && self.dataPickerViewIsShowingCities==NO)
    {
        [self hideDataPickerCell];
        return 0.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        if(self.dataPickerViewIsShowingCities)
        {
            [self hideDataPickerCell];
        }
        else
        {
            [self showCityPickerCell];
        }
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
