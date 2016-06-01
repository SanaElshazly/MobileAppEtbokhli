//
//  HomePageTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "HomePageTableViewController.h"


@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"allMeals"]) {
        _meals = [[NSMutableArray alloc] initWithArray:dataRetreived];
        [mealsRequestedDBFunctions insertMenuItems:_meals];
        _meals=[mealsRequestedDBFunctions fetchAndGetAllMenuItems];
         NSLog(@"meals data %@", _meals );
    }
    else if ([serviceName isEqualToString:@"allCooks"])
    {
        _cooks=[[NSMutableArray alloc] initWithArray:dataRetreived];
        [cookRequestedDBFunctions insertCooks:_cooks];
        _cooks=[cookRequestedDBFunctions fetchAndGetAllCooks];
        NSLog(@"pppooo %@",_cooks);
    }
    [self refreshDataInTableView];
   
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView function");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection function");
    NSInteger arrayLength=0;
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            arrayLength = [_cooks count];
            NSLog(@"arrayLength of cooks %d", arrayLength);
            break;
            
        case 1:
            arrayLength = [_meals count];
            NSLog(@"arrayLength of meals %d", arrayLength);
            break;
            
        default:
            break;
    }
    return arrayLength;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath function");
    
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    UIImageView *listItemImage=(UIImageView *)[cell viewWithTag:1];
    UILabel *listItemHeader=(UILabel *)[cell viewWithTag:2];
    UILabel *listItemSubHeader=(UILabel *)[cell viewWithTag:3];
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            listItemHeader.text=[(Cook *)[_cooks objectAtIndex:indexPath.row] name] ;
            listItemSubHeader.text=[(Cook *)[_cooks objectAtIndex:indexPath.row] address] ;
            NSLog(@"urlll%@",[NSString stringWithFormat: @"%@",[(Cook*)[ _cooks objectAtIndex:indexPath.row] imageURL]]);
            [listItemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",[(Cook*)[ _cooks objectAtIndex:indexPath.row] imageURL]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
            break;
            
        case 1:
            listItemHeader.text=[(MenuItems *)[_meals objectAtIndex:indexPath.row] nameEn];
            listItemSubHeader.text=[NSString stringWithFormat:@"%f",[(MenuItems *)[_meals objectAtIndex:indexPath.row] price]] ;
            NSLog(@"%@",[NSString stringWithFormat: @"%@",[(MenuItems*)[ _meals objectAtIndex:indexPath.row] imageURL]]);
            [listItemImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",[(MenuItems*)[ _meals objectAtIndex:indexPath.row] imageURL]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
            
            break;
        default:
            break;
    }
    
    return cell;
}


-(void)refreshDataInTableView
{
    [self.dataTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"geeeh");
    networkDelegate=self;
    mealsRequestedService = [[MealsServices alloc] initWithNetWorkDelegate:networkDelegate];
    
    cooksRequestedMeals=[[CookServices alloc]initWithNetworkDelegate:networkDelegate];
    cookRequestedDBFunctions=[[CookDAO alloc] initWithManagedObject];
    mealsRequestedDBFunctions=[[MenuItemDAO alloc] initWithManagedObject];
    [self checkConnectivity];
    
}
-(IBAction)changeValueOfSegmentedController:(id)sender {
    NSLog(@"3mlt aho");
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            if (_isUserReachable) {
                    [cooksRequestedMeals getCooksListDataService];
                }
            else
            {
                _cooks=[cookRequestedDBFunctions fetchAndGetAllCooks];
                [self refreshDataInTableView];
            }
            break;
        case 1 :
            if (_isUserReachable) {
                [mealsRequestedService getMealsListDataService];
            }
            else
            {
                _meals=[mealsRequestedDBFunctions fetchAndGetAllMenuItems];
                [self refreshDataInTableView];
            }
            break;
        default:
            break;
    }
}
-(void)checkConnectivity
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([AFStringFromNetworkReachabilityStatus(status) isEqualToString:@"Not Reachable"]) {
            _isUserReachable=NO;
            [self changeValueOfSegmentedController:self];
        }
        else
        {
            _isUserReachable=YES;
            [self changeValueOfSegmentedController:self];
        }
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        _isUserReachable=YES;
    }
    else
        _isUserReachable=NO;
}
@end
