//
//  homePageViewController.m
//  Etbo5ly
//
//  Created by ITI on 5/21/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "TabBarViewController.h"
#import "SWRevealViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

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



@end
