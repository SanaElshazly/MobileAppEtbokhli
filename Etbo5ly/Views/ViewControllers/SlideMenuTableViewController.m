//
//  SlideMenuTableViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "SlideMenuTableViewController.h"

@interface SlideMenuTableViewController ()

@end

@implementation SlideMenuTableViewController
{
    BOOL profileCellHidden;
    NSString *email;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    userRequestedFunctions=[[UserDAO alloc] initWithManagedObject];
    email=[userRequestedFunctions selectRegisteredUser].email;
    if (email!=nil) {
        _signInCell.textLabel.text=@"Logout";
    }
    else
    {
        profileCellHidden=YES;
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
   email=[userRequestedFunctions selectRegisteredUser].email;
    if (email!=nil) {
        profileCellHidden=NO;
        _signInCell.textLabel.text=@"Logout";
        [self.tableView reloadData];
    }
    else
    {
        profileCellHidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[super tableView: tableView cellForRowAtIndexPath:indexPath];
    if (cell==_profileCell && profileCellHidden) {
       // _profileCell.hidden=YES;
        return 0.0;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BOOL signOutResult;
    if ([segue.identifier isEqualToString:@"signUp"]) {
        if ([_signInCell.textLabel.text isEqualToString:@"Logout"]) {
            signOutResult=[userRequestedFunctions deleteUser];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindowWidth:300.0f];
            [alert showWaiting:self title:@"Waiting..." subTitle:@"Logging Out" closeButtonTitle:nil duration:5.0f];
            
        }
        if (signOutResult==YES) {
            
            _signInCell.textLabel.text=@"Sign In";
            profileCellHidden=YES;
            
            [self.tableView reloadData];
        }
    }
}

@end
