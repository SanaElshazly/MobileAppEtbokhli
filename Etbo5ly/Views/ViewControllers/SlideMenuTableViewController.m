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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    userRequestedFunctions=[[UserDAO alloc] initWithManagedObject];
    NSString *email=[userRequestedFunctions selectRegisteredUser].email;
    if (email!=nil) {
        _signInCell.textLabel.text=@"Logout";
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        }
    }
}
@end
