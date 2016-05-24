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


- (void)viewDidLoad {
    [super viewDidLoad];
    //networkDelegate=self;
    mealsRequestedService = [[MealsServices alloc] init];
    
    
    [self changeValueOfSegmentedController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void) getCooksListDataService {
//    
//    
////    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
////    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    //[spinner startAnimating];
//    NSLog(@"d5l fun get cooks");
//    serviceName=@"allCooks";
//    serviceURL = [NSString stringWithFormat:@"%@",[URLS allCooks:-1]];
//    NSLog(serviceURL);
//    
//    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];
//}

//-(void) getMealsListDataService{
//    serviceName=@"allMeals";
//    serviceURL = [NSString stringWithFormat:@"%@",[URLS allMeals:-1]];
//    NSLog(serviceURL);
//    
//    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];
//}


//-(void)handle:(id)dataRetreived :(NSString *)serviceName{
//
//    NSLog(@"handle function");
//    if ([serviceName isEqualToString:@"allCooks"]) {
//        cooks = [[NSMutableArray alloc] initWithArray:dataRetreived];
//    }
//    else
//        meals = [[NSMutableArray alloc] initWithArray:dataRetreived];
//    
//    NSLog(@"cooks data %@", cooks );
//    [self refreshDataInTableView];
//}
//
//-(void)handleWithFailure:(NSError *)error{
//    NSLog(@"ERRORRRRR");
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView function");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection function");
    NSInteger arrayLength=0;
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            arrayLength = [cooks count];
            NSLog(@"arrayLength of cooks %d", arrayLength);
            break;
            
//        case 1:
//            arrayLength = [meals count];
//            NSLog(@"arrayLength of meals %d", arrayLength);
//            break;
            
        default:
            break;
    }
    return arrayLength;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath function");
    
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            cell.textLabel.text=[[cooks objectAtIndex:indexPath.row] objectForKey:@"name"];
            break;
            
//        case 1:
//            cell.textLabel.text=[[meals objectAtIndex:indexPath.row] objectForKey:@"nameEn"];
//            break;
        default:
            break;
    }
    
    return cell;
}

-(void) refreshDataInTableView
{
    [self.dataTableView reloadData];
}
- (IBAction)changeValueOfSegmentedController:(id)sender {
    NSLog(@"3mlt aho");
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            //[self getCooksListDataService ];
            break;
        case 1 :
            //[self getMealsListDataService];
            meals= [mealsRequestedService getMealsListDataService];
            NSLog(@"%@",meals);
            //[self refreshDataInTableView];
            break;
//        case 1 :
//            [self getMealsListDataService];
//            break;
        default:
            break;
    }
}



@end
