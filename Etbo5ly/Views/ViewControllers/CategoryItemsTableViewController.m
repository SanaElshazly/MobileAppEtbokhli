//
//  CategoryItemsTableViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/11/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "CategoryItemsTableViewController.h"

@interface CategoryItemsTableViewController ()

@end

@implementation CategoryItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    networkDelegate=self;
    cooksRequestedCategories=[[CookServices alloc]initWithNetworkDelegate:networkDelegate];
    [cooksRequestedCategories getCookCategoryMeals:_cookID : _categoryID];

    //int i = [_cookObj userId];
    //NSString *s =[_categoryItems nameEn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"cookCategoryMeals"]) {
        _cookCategoryItems = [[NSMutableArray alloc] initWithArray:dataRetreived];
        NSLog(@"category items are:  %@", _cookCategoryItems );
    }
    
    [self.categoryItemsTable reloadData];
    
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSInteger categoryItemsLength = [_cookCategoryItems count];
    
    return categoryItemsLength;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [_categoryItemsTable dequeueReusableCellWithIdentifier:cellID ];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
//    cell.textLabel.textColor = [UIColor brownColor];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    
    cell.textLabel.text=[[self.cookCategoryItems objectAtIndex:indexPath.row] objectForKey:@"nameEn"];
    cell.detailTextLabel.text=[[self.cookCategoryItems objectAtIndex:indexPath.row] objectForKey:@"price"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@%@",[[ self.cookCategoryItems objectAtIndex:indexPath.row] objectForKey:@"resourcesURL"], [[ self.cookCategoryItems objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]] placeholderImage:[UIImage imageNamed:@"ios.png"]];


//    NSLog(@"%@",[NSString stringWithFormat: @"%@",[(MenuItems*)[ _meals objectAtIndex:indexPath.row] imageURL]]);
    
    // Configure the cell...
    
    return cell;
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
