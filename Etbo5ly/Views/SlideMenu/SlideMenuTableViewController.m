//
//  SlideMenueTableViewController.m
//  Etbo5ly
//
//  Created by ITI on 5/21/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "SlideMenuTableViewController.h"
#import "SWRevealViewController.h"
@interface SlideMenuTableViewController ()

@end

@implementation SlideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    slideMenuItems=@[@"loginPage",@"profilePage",@"orderHistoryPage"];
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
    return slideMenuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier=[slideMenuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue isKindOfClass:[SWRevealViewControllerSegue class]])
    {
        SWRevealViewControllerSegue *swSegue=(SWRevealViewControllerSegue*) segue;
        swSegue.performBlock=^(SWRevealViewControllerSegue * rvc_segue,UIViewController* svc,UIViewController* dvc)
        {
            UINavigationController *nevController=(UINavigationController*)self.revealViewController.frontViewController;
            [nevController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated:YES];
        };
        
    }
}
@end
