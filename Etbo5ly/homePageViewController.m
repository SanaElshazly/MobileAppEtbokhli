//
//  homePageViewController.m
//  Etbo5ly
//
//  Created by ITI on 5/21/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "homePageViewController.h"
#import "SWRevealViewController.h"
@interface homePageViewController ()

@end

@implementation homePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewSlideMenuButtonItem.target=self.revealViewController;
    _viewSlideMenuButtonItem.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
