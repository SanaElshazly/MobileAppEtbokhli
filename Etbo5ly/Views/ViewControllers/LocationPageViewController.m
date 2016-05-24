//
//  LocationPageViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 5/23/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "LocationPageViewController.h"

@interface LocationPageViewController ()

@end

@implementation LocationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countries=@[@"egypt",@"alex",@"Ismalia"];
    cities=@[@"shoubra",@"nasr city",@"El haram"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    int arrCount=0;
    if (component==0) {
        arrCount=countries.count;
    }
    else
        arrCount = [cities count];
    return arrCount;
}
-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * str;
    if (component==0) {
        str=[countries objectAtIndex:row];
    }
    else
        str =[cities objectAtIndex:row];
    return str;
}
@end
