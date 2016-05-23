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
    
    [self getCooksListDataService ];

    // Setting Up Table View
    self.dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.dataTableView.hidden = YES;
    [self.view addSubview:self.dataTableView];
    
    
    //[Etbo5lyNetworkManager connectGET:@"meal/page?page=1" :@"meals" :self];
//    switch (self.menuOptions.selectedSegmentIndex) {
//        case 0:
//            [self getCooksListDataService ];
//            break;
//        case 1 :
//            break;
//        default:
//            break;
//    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.dataTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getCooksListDataService {
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //[spinner startAnimating];
    NSLog(@"d5l fun get cooks");
    
    NSString *serviceName=@"allCooks";
    NSString *serviceURL = [NSString stringWithFormat:@"%@",[URLS allCooks:1]];
    NSLog(serviceURL);
    
//    homePageNetworkManager = [Etbo5lyNetworkManager new];
//    
//    homePageNetworkManager = networkDelegate.self;
    networkDelegate=self;
    
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName{

    NSLog(@"handle function");
    cooks = [[NSMutableArray alloc] initWithArray:dataRetreived];
    NSLog(@"cooks data %@", cooks );
    [_dataTableView reloadData];
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
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
            
        case 1:
            arrayLength = [meals count];
            NSLog(@"arrayLength of meals %d", arrayLength);
            break;
            
        default:
            break;
    }
    return arrayLength;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath function");
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    // Configure the cell...
    
    cell.textLabel.text=[[cooks objectAtIndex:indexPath.row] objectForKey:@"name"];

//    switch (self.menuOptions.selectedSegmentIndex) {
//        case 0:
//            //cell.textLabel.text=cooks[indexPath.row];
//            cell.textLabel.text=[[cooks objectAtIndex:indexPath.row] objectForKey:@"name"];
//            break;
//            
//        case 1:
//            cell.textLabel.text=[[meals objectAtIndex:indexPath.row] objectForKey:@"cookName"];
//            break;
//            
//        default:
//            break;
//    }
    
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
