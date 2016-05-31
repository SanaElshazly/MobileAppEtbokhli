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
{
    CLLocationManager *locationManager;
    CLLocation *crnLoc;
    NSString *selectedRegionName;
    NSString *selectedCityName;
    int regionID;
    int cityID;
    int pickerCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTextFieldBorderStyle:self.regionTxtField];
    [self addTextFieldBorderStyle:self.cityTxtField];

    networkDelegate=self;
    pickerCount=0;
    _regionTxtField.delegate=self;
    _regionTxtField.placeholder=@"Region";
    
    _cityTxtField.delegate=self;
    _cityTxtField.placeholder=@"City";
    
    _pickerViewHeaderLabel.hidden=YES;
    _pickerViewHeaderBtn.hidden=YES;
    _pickerViewData.hidden=YES;
    locationManager = [[CLLocationManager alloc]init];
    locationRequestedServices=[[locationServices alloc] initWithNetworkDelegate:networkDelegate];
    cooksRequestedServices=[[CookServices alloc] initWithNetworkDelegate:networkDelegate];
    self.navigationItem.backBarButtonItem = [self creatBackBotton];
   
    [locationRequestedServices getAllRegions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    int arrCount=0;
    if (component==0) {
        if (isCitiesTxtFieldSelected==YES) {
            arrCount=allCities.count;
        }
        else
        {
            arrCount=allRegions.count;
        }
    }
    
    return arrCount;
}
-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * dataInPickerView;
//    if (row==0) {
//        if (isCitiesTxtFieldSelected==YES) {
//            dataInPickerView=@"Select City....";
//        }
//        else
//            dataInPickerView=@"Select Region...";
//    }
//    else
//    {
        if (isCitiesTxtFieldSelected==YES) {
            dataInPickerView=[[allCities objectAtIndex:row] objectForKey:@"cityName"];
        }
        else
        {
            dataInPickerView=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
        }
    //}
    return dataInPickerView;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (isCitiesTxtFieldSelected==YES)
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
    else if ([serviceName isEqualToString:@"allCooksBasedOnLocation"])
    {
        cooksBasedLocation=[[NSArray alloc] initWithArray:dataRetreived];
        CooksBasedOnLocationTableViewController *cooksBasedOnLocationTableView=[CooksBasedOnLocationTableViewController new];
        [cooksBasedOnLocationTableView setCooksOnLocation:cooksBasedLocation];
        
        [self.navigationController pushViewController:cooksBasedOnLocationTableView animated:YES];

    }
    else if ([serviceName isEqualToString:@"cooksByRegion"])
    {
        cooksBasedLocation=[[NSArray alloc] initWithArray:dataRetreived];
        CooksBasedOnLocationTableViewController *cooksBasedOnLocationTableView=[CooksBasedOnLocationTableViewController new];
        [cooksBasedOnLocationTableView setCooksOnLocation:cooksBasedLocation];
        
        [self.navigationController pushViewController:cooksBasedOnLocationTableView animated:YES];
    }

}
-(void)handleWithFailure:(NSError *)error
{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (!_didGetLocation) {
        _didGetLocation=YES;
        crnLoc = [CLLocation alloc];
        crnLoc = [locations lastObject];
        NSLog(@"latitude %@",[NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude]);
        userLatitude=crnLoc.coordinate.latitude;
        userLongitude=crnLoc.coordinate.longitude;
         [cooksRequestedServices getCooksBasedOnLocation:userLatitude setLongitude:userLongitude];
    }

}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error.description);
}
- (IBAction)detectUserLocation:(id)sender {
    NSLog(@"h");
    _didGetLocation=NO;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate =self; 
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
   
}

- (IBAction)getAllCooksByRegion:(id)sender {
    NSLog(@"dost");
    [cooksRequestedServices getCooksByRegion:regionID];
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        isCitiesTxtFieldSelected=YES;
        [[self pickerViewData ]reloadAllComponents];
        _pickerViewHeaderLabel.hidden=NO;
        _pickerViewHeaderBtn.hidden=NO;
        _pickerViewData.hidden=NO;
        _showCooksBtn.hidden=YES;
        return NO;
    }
    else if (textField.tag == 2)
    {
        isCitiesTxtFieldSelected=NO;
        [[self pickerViewData ]reloadAllComponents];
        _pickerViewHeaderLabel.hidden=NO;
        _pickerViewHeaderBtn.hidden=NO;
        _pickerViewData.hidden=NO;
        _showCooksBtn.hidden=YES;
        return NO;
    }
    
    return YES;
    
}

- (IBAction)hidePickerViewBtn:(id)sender {
    if (isCitiesTxtFieldSelected==YES)
    {
        _cityTxtField.text=selectedCityName;
        if ([_cityTxtField.text  isEqualToString:@""]) {
            _cityTxtField.text=[[allCities objectAtIndex:0] objectForKey:@"cityName"];
            selectedCityName=[[allCities objectAtIndex:0] objectForKey:@"cityName"];
            cityID=[[[allCities objectAtIndex:0] objectForKey:@"cityId"] integerValue];
        }
        
        for (int i=0; i<=allCities.count; i++) {
            NSLog(@"int %d",[[[allCities objectAtIndex:i] objectForKey:@"cityId"] integerValue]);
            if ([[[allCities objectAtIndex:i] objectForKey:@"cityId"] integerValue]==cityID) {
                allRegions=[[allCities objectAtIndex:i] objectForKey:@"regions"];
                //  [[allRegions objectAtIndex:i] objectForKey:@"regions"];
                NSLog(@"hobaa%@",allRegions);
                break;
            }
        }
        
    }
    else
    {
        _regionTxtField.text=selectedRegionName;
        if ([_regionTxtField.text  isEqualToString:@""]) {
            _regionTxtField.text=[[allRegions objectAtIndex:0] objectForKey:@"regionName"];
        }
        NSLog(@"hnaa");
    }
    _pickerViewHeaderLabel.hidden=YES;
    _pickerViewHeaderBtn.hidden=YES;
    _pickerViewData.hidden=YES;
    _showCooksBtn.hidden=NO;
}
-(UIBarButtonItem *) creatBackBotton
{
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    return myBackButton;
}


-(void) addTextFieldBorderStyle: (UITextField*) txtField{
    
    CALayer *bottomBorder = [CALayer layer];
    CGFloat borderWidth = 2;
    bottomBorder.borderWidth = borderWidth;
    bottomBorder.borderColor = [[UIColor orangeColor]CGColor];
    
    bottomBorder.frame = CGRectMake(0.0f, txtField.frame.size.height - borderWidth, txtField.frame.size.width,txtField.frame.size.height);
    bottomBorder.backgroundColor = [UIColor orangeColor].CGColor;
    [txtField.layer addSublayer:bottomBorder];
}

@end
