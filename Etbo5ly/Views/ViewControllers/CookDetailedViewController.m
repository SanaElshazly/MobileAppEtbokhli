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
{
    NSString *formattedDate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"geeeh");
    networkDelegate=self;
    cooksRequestedCategories=[[CookServices alloc]initWithNetworkDelegate:networkDelegate];
    
    
    
    _cookNameLbl.text=[_detailedCook name];
    [_cookProfileImg sd_setImageWithURL:[NSURL URLWithString:[_detailedCook imageURL]] placeholderImage:[UIImage imageNamed:@"etbokhliLogo.png"]];
    _cookAddressLbl.text=[_detailedCook address];
    
    formattedDate =[NSString stringWithFormat:@"%@",[_detailedCook startWorkingHours]];
    formattedDate =[self prepareDate:formattedDate];
    NSLog(@"%@", formattedDate);
    
    _cookWorkingHrsLbl.text=[NSString stringWithFormat:@"%@ - %@",[_detailedCook startWorkingHours] ,
                             [_detailedCook endWorkingHours] ];
    
    
//     NSLog(@"%@",[NSDate dateWithTimeIntervalSince1970:([[[cooksArray objectAtIndex:i ] objectForKey:@"registerationDate"] longLongValue]/1000.0)]);
    
//    _detailedMealPrice.text=[NSString stringWithFormat:@"%f",[_detailedMeal price] ];
    //_MealQuantity.text=[NSString stringWithFormat:@"%d",quantity];
    //_totalItemPrice.text=[NSString stringWithFormat:@"%f",([_detailedMealPrice.text floatValue] * quantity)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellIdentifier";
    
    UITableViewCell *cell = [_cookMenuTableView dequeueReusableCellWithIdentifier:cellID ];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    return cell;
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
