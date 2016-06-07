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
    locationRequestedServices=[[locationServices alloc] initWithNetworkDelegate:networkDelegate];
    searchResults=[[NSArray alloc] init];
    refreshControl=[[UIRefreshControl alloc] init];
    refreshControl.backgroundColor=[UIColor orangeColor];
    refreshControl.tintColor=[UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(changeValueOfSegmentedController:) forControlEvents:UIControlEventValueChanged];
   
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
    else if  ([serviceName isEqualToString:@"allRegionsWithCountries"]) {
        allCountries=[[NSMutableArray alloc] initWithArray:dataRetreived ];
        allCountries=[[allCountries objectAtIndex:0] objectForKey:@"cities"];
        allCities=[[NSMutableArray alloc] initWithArray:allCountries];
        //      allRegions=[[allCountries objectAtIndex:0] objectForKey:@"regions"];
        NSLog(@"countries %@",allCountries);
        NSLog(@"ciyies %@",allCities);
        //  NSLog(@"region %@",allRegions);
        
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
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                arrayLength =  [searchResults count];
                
            }
            else
            {
            arrayLength = [_cooks count];
            NSLog(@"arrayLength of cooks %d", arrayLength);
            }
            break;
            
        case 1:
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                arrayLength =  [searchResults count];
                
            }
            else
            {
            arrayLength = [_meals count];
            NSLog(@"arrayLength of meals %d", arrayLength);
            }
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
//            if (tableView == self.searchDisplayController.searchResultsTableView) {
//                _cooks = searchResults ;
//            }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",[(MenuItems *)[_meals objectAtIndex:indexPath.row] nameEn]);
    UIStoryboard *storyboard=self.navigationController.storyboard;
    MealDetailedViewController *mealDetailedViewController=[storyboard instantiateViewControllerWithIdentifier:@"detailedMealViewController"];
    [mealDetailedViewController setDetailedMeal:(MenuItems *)[_meals objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:mealDetailedViewController animated:YES];

    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [_cooks filteredArrayUsingPredicate:resultPredicate];
    _cooks=searchResults;
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
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
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
      //  [refreshControl endRefreshing];
    }
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
