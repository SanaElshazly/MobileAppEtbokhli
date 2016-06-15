//
//  CookDetailedViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/10/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "CookDetailedViewController.h"

@interface CookDetailedViewController ()

@end

@implementation CookDetailedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_cookProfileImg.layer setBorderColor: [[UIColor orangeColor] CGColor]];
    [_cookProfileImg.layer setBorderWidth: 2.0];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"geeeh");
    
    cookIDforCategory = [_detailedCook userId] ;

    networkDelegate=self;
    cooksRequestedCategories=[[CookServices alloc]initWithNetworkDelegate:networkDelegate];
    [cooksRequestedCategories getCookCategories:cookIDforCategory];
    
    
    _cookNameLbl.text=[_detailedCook name];
    [_cookProfileImg sd_setImageWithURL:[NSURL URLWithString:[_detailedCook imageURL]] placeholderImage:[UIImage imageNamed:@"icon_etbokhlyPlaceholder.png"]];
    _cookAddressLbl.text=[_detailedCook address];

    
    startWorkingHoursDate=[_detailedCook startWorkingHours];
    endWorkingHoursDate=[_detailedCook endWorkingHours];
    _cookRatingView.value=[_detailedCook cookRate];
    NSDate *startDateFormatted =[NSDateFormatter localizedStringFromDate:startWorkingHoursDate dateStyle:NSDateFormatterNoStyle timeStyle:NSTimeIntervalSince1970];
    
    
    NSDate *endDateFormatted =[NSDateFormatter localizedStringFromDate:endWorkingHoursDate dateStyle:NSDateFormatterNoStyle timeStyle:NSTimeIntervalSince1970];
        
    
    _cookWorkingHrsLbl.text=[NSString stringWithFormat:@"From: %@",startDateFormatted ] ;
     _cookEndWorkingHrsLbl.text=[NSString stringWithFormat:@"To: %@",endDateFormatted ] ;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"cookCategories"]) {
        _cookCategories = [[NSMutableArray alloc] initWithArray:dataRetreived];
        NSLog(@"cooks categories ARE  %@", _cookCategories );
    }
    
    [self.cookMenuTableView reloadData];
    
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger categoriesLength = [_cookCategories count];
    
    return categoriesLength;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellIdentifier";
    
    UITableViewCell *cell = [_cookMenuTableView dequeueReusableCellWithIdentifier:cellID ];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSLog(@" Category is: %@",[[self.cookCategories objectAtIndex:indexPath.row] objectForKey:@"nameEn"]);
    cell.textLabel.textColor = [UIColor brownColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text=[[self.cookCategories objectAtIndex:indexPath.row] objectForKey:@"nameEn"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",[[_cookCategories objectAtIndex:indexPath.row] objectForKey:@"nameEn" ]);
    NSLog(@"%@",[[_cookCategories objectAtIndex:indexPath.row] objectForKey:@"categoryId" ]);

    int catID =[[[_cookCategories objectAtIndex:indexPath.row] objectForKey:@"categoryId" ] integerValue];
    
    UIStoryboard *storyboard=self.navigationController.storyboard;
    CategoryItemsTableViewController *categoryItemsTableViewController=[storyboard instantiateViewControllerWithIdentifier:@"categoryItemsTableViewController"];
    [categoryItemsTableViewController setCategoryName:[[self.cookCategories objectAtIndex:indexPath.row] objectForKey:@"nameEn"]];
    [categoryItemsTableViewController setCategoryID:catID];
    [categoryItemsTableViewController setCookID:cookIDforCategory];
    
    [self.navigationController pushViewController:categoryItemsTableViewController animated:YES];
    
}



-(NSString*) prepareDate :(NSString*) workingHrs{
    NSString *dateStr=workingHrs;
    
    // Create a date formatter
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    
    // As rmaddy pointed out, you should set the locale:
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    // Set the date format for the input string
    [formatter setDateFormat:@"dd/MM/yyyy hh:mma"];
    
    // Create the NSDate from the string
    NSDate *date=[formatter dateFromString:dateStr];
    
    // Set the date format for the output string
    [formatter setDateFormat:@"hh:mma"];
    
    // Create the output string
    NSString *finalDate=[formatter stringFromDate:date];
    NSLog(@"%@",finalDate);  //  Output is: 02:00AM
    return finalDate;
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
