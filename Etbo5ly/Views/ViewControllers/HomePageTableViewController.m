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
    _getCooksBasedOnLocation=NO;
    NSLog(@"mgashh");

}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"allMeals"]) {
        meals = [[NSArray alloc] initWithArray:dataRetreived];
        
    }
    else if ([serviceName isEqualToString:@"allCooks"])
    {
        _cooks=[[NSArray alloc] initWithArray:dataRetreived];
    }
    [self refreshDataInTableView];
    NSLog(@"meals data %@", meals );
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
            arrayLength = [meals count];
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
//    
//    NSURL *imgURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[cooks objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[cooks objectAtIndex:indexPath.row] objectForKey:@"imageURL"]]];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            cell.textLabel.text=[[_cooks objectAtIndex:indexPath.row] objectForKey:@"name"];
            NSLog(@"g%@",[NSString stringWithFormat:@"%@%@",[[_cooks objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[_cooks objectAtIndex:indexPath.row] objectForKey:@"imageURL"]]);
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[_cooks objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[_cooks objectAtIndex:indexPath.row] objectForKey:@"imageURL"]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
            break;
            
        case 1:
            cell.textLabel.text=[[meals objectAtIndex:indexPath.row] objectForKey:@"nameEn"];
             NSLog(@"g=h%@",[NSString stringWithFormat:@"%@%@",[[meals objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[meals objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]);
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[meals objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"],[[meals objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
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
    [self changeValueOfSegmentedController:self];
}
-(IBAction)changeValueOfSegmentedController:(id)sender {
    NSLog(@"3mlt aho");
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            if (_getCooksBasedOnLocation==NO) {
                [cooksRequestedMeals getCooksListDataService];
            }
            else
            {
                
            }
            break;
        case 1 :
            //[self getMealsListDataService];
            [mealsRequestedService getMealsListDataService];
            NSLog(@"%@",meals);
            //[self refreshDataInTableView];
            break;
        default:
            break;
    }
}
@end
