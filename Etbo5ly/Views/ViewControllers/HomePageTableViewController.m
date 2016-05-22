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
    [Etbo5lyNetworkManager connectGET:@"meal/page?page=1" :@"meals" :self];
    [self getCooksListDataService ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getCooksListDataService {
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[spinner startAnimating];
    
    
    NSString *serviceName=@"allCooks";
    NSString *serviceURL = [NSString stringWithFormat:@"%@",[URLS allCooks:1]];
    
    homePageNetworkManager = [Etbo5lyNetworkManager new];
    
    homePageNetworkManager = networkDelegate.self;
    
    [Etbo5lyNetworkManager connectGET:serviceURL :serviceName :homePageNetworkManager];
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName{

    cooks = [[NSMutableArray alloc] initWithArray:dataRetreived];
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSInteger arrayLength=0;
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            arrayLength = [cooks count];
            break;
            
        case 1:
            arrayLength = [meals count];
            break;
            
        default:
            break;
    }
    return arrayLength;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier" ];
    }
    // Configure the cell...
    
    switch (self.menuOptions.selectedSegmentIndex) {
        case 0:
            //cell.textLabel.text=cooks[indexPath.row];
            cell.textLabel.text=[[cooks objectAtIndex:indexPath.row] objectForKey:@"cookName"];
            break;
            
        case 1:
            cell.textLabel.text=[[meals objectAtIndex:indexPath.row] objectForKey:@"cookName"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (IBAction)changeMenuOption:(id)sender {
    [self.dataTableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
