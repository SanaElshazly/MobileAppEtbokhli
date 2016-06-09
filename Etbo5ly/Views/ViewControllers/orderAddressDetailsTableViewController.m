//
//  orderAddressDetailsTableViewController.m
//  Etbo5ly
//
//  Created by MDW Event on 6/8/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "orderAddressDetailsTableViewController.h"

@interface orderAddressDetailsTableViewController ()

@end

@implementation orderAddressDetailsTableViewController
{
    NSString *selectedRegionName;
    NSString *selectedCityName;
    int regionID;
    int cityID;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cityTxtField.delegate=self;
    _regionTxtField.delegate=self;
    [self getAllRegionsAndCities];
//    [self addTextFieldBorderStyle:self.cityTxtField];
//    [self addTextFieldBorderStyle:self.regionTxtField];
//    [self addTextFieldBorderStyle:self.streetTxtField];
//    [self addTextFieldBorderStyle:self.buildingNumberTxtField];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
}
-(void) getAllRegionsAndCities
{
    networkDelegate=self;

    locationRequestedService=[[locationServices alloc] initWithNetworkDelegate:networkDelegate];
    [locationRequestedService getAllRegions];
}
#pragma mark - Table view data source


-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField{//:(UITextField*) txtField{
    
    CALayer *bottomBorder = [CALayer layer];
    CGFloat borderWidth = 1;
    bottomBorder.borderWidth = borderWidth;
    bottomBorder.borderColor = [[UIColor orangeColor]CGColor];
    
    bottomBorder.frame = CGRectMake(0.0f, txtField.frame.size.height - borderWidth, txtField.frame.size.width,txtField.frame.size.height);
    bottomBorder.backgroundColor = [UIColor orangeColor].CGColor;
    txtField.floatLabelActiveColor = [UIColor orangeColor];
    [txtField.layer addSublayer:bottomBorder];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1 && indexPath.row==1 && self.dataPickerViewIsShowingCities==NO)
    {
        [self hideDataPickerCity];
        return 0.0f;
    }
    else if (indexPath.section==1 && indexPath.row==3 && self.dataPickerViewIsShowingRegions==NO)
    {
        [self hideRegionPicker];
        return 0.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    int arrCount=0;
    if (self.dataPickerViewIsShowingCities) {
        arrCount=allCities.count;
    }
    else if (self.dataPickerViewIsShowingRegions)
    {
        arrCount=allRegions.count;
    }
    return arrCount;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * dataInPickerView;
    if (self.dataPickerViewIsShowingCities) {
        dataInPickerView=[[allCities objectAtIndex:row] objectForKey:@"cityName"];
    }
    else if (self.dataPickerViewIsShowingRegions)
    {
        dataInPickerView=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
    }
    
    return dataInPickerView;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.dataPickerViewIsShowingCities)
    {
        NSLog(@"city %@",[[allCities objectAtIndex:row] objectForKey:@"cityName"]);
        selectedCityName=[[allCities objectAtIndex:row] objectForKey:@"cityName"];
        cityID=[[[allCities objectAtIndex:row] objectForKey:@"cityId"] integerValue];
    }
    else
    {
        regionID=[[[allRegions objectAtIndex:row] objectForKey:@"regionId"] integerValue];
        selectedRegionName=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
        
        NSLog(@"%d",regionID);
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        NSLog(@"hwll");
        if(self.dataPickerViewIsShowingCities)
        {
            [self hideDataPickerCity];
        }
        else
        {
            [self showCityPickerCell];
            [_pickerViewCities reloadAllComponents];
        }
        return NO;
    }
    if (textField.tag==2)
    {
        if(self.dataPickerViewIsShowingRegions)
        {
            [self hideRegionPicker];
        }
        else
        {
            [self showRegionPickerCell];
            [_pickerViewRegions reloadAllComponents];
        }
        return NO;
    }
    return YES;
}
-(void) showCityPickerCell
{
    self.dataPickerViewIsShowingCities=YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.pickerViewCities.hidden=NO;
    self.pickerViewCities.alpha=0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerViewCities.alpha=1.0f;
    }];
}
-(void) showRegionPickerCell
{
    self.dataPickerViewIsShowingRegions=YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.pickerViewRegions.hidden=NO;
    self.pickerViewRegions.alpha=0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerViewRegions.alpha=1.0f;
    }];
}
-(void) hideDataPickerCity
{
    self.dataPickerViewIsShowingCities=NO;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerViewCities.alpha=0.0f;
    }
            completion:^(BOOL fininshed){
                         self.pickerViewCities.hidden=YES;
            }];
    for (int i=0; i<=allCities.count; i++) {
        NSLog(@"int %d",[[[allCities objectAtIndex:i] objectForKey:@"cityId"] integerValue]);
        if ([[[allCities objectAtIndex:i] objectForKey:@"cityId"] integerValue]==cityID) {
            allRegions=[[allCities objectAtIndex:i] objectForKey:@"regions"];
            //  [[allRegions objectAtIndex:i] objectForKey:@"regions"];
            NSLog(@"hobaa%@",allRegions);
            break;
        }
    }
    _cityTxtField.text=selectedCityName;
}

-(void) hideRegionPicker
{
    self.dataPickerViewIsShowingRegions=NO;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerViewRegions.alpha=0.0f;
    }
                     completion:^(BOOL fininshed){
                         self.pickerViewRegions.hidden=YES;
                     }];
    _regionTxtField.text=selectedRegionName;
}
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"allRegionsWithCountries"]) {
        allCountries=[[NSMutableArray alloc] initWithArray:dataRetreived ];
        allCountries=[[allCountries objectAtIndex:0] objectForKey:@"cities"];
        allCities=[[NSMutableArray alloc] initWithArray:allCountries];
        //      allRegions=[[allCountries objectAtIndex:0] objectForKey:@"regions"];
        NSLog(@"countries %@",allCountries);
        NSLog(@"ciyies %@",allCities);
        //  NSLog(@"region %@",allRegions);
        
    }
}
- (IBAction)placeOrderBtn:(id)sender {
}
@end
