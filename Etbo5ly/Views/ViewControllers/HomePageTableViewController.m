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
    
    cooksRequestedServices=[[CookServices alloc]init];
    cooks=[cooksRequestedServices getCooksListDataService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            cooks=[cooksRequestedServices getCooksListDataService];
            break;
//        case 1 :
//            [self getMealsListDataService];
//            break;
        default:
            break;
    }
}



@end
