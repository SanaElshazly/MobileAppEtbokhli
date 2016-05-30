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
    int regionID;
    int pickerCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.regionTxtField setBorderStyle:UITextBorderStyleRoundedRect];
    
    self.regionTxtField.layer.borderWidth= 2;
    self.regionTxtField.layer.cornerRadius = 5;
    self.regionTxtField.clipsToBounds = YES;
    self.regionTxtField.layer.borderColor= [[UIColor orangeColor]CGColor];
    
    
    self.cityTxtField.layer.borderWidth= 2;
    self.cityTxtField.layer.cornerRadius = 5;
    self.cityTxtField.clipsToBounds = YES;
    self.cityTxtField.layer.borderColor= [[UIColor orangeColor]CGColor];


    
    networkDelegate=self;
    pickerCount=0;
    _regionTxtField.delegate=self;
    _regionTxtField.placeholder=@"Select region ... ";
    
    _cityTxtField.delegate=self;
    _cityTxtField.placeholder=@"Select city ... ";
    
    _pickerViewHeaderLabel.hidden=YES;
    _pickerViewHeaderBtn.hidden=YES;
    _pickerViewData.hidden=YES;
    locationManager = [[CLLocationManager alloc]init];
    locationRequestedServices=[[locationServices alloc] initWithNetworkDelegate:networkDelegate];
    cooksRequestedServices=[[CookServices alloc] initWithNetworkDelegate:networkDelegate];
    self.navigationItem.backBarButtonItem = [self creatBackBotton];
   
//    allRegions=@[@{@"regionName":@"shoubra"},@{@"regionName":@"El Haram"},@{@"regionName":@"El Maadi"},@{@"regionName":@"Nasr City"}];
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
    NSString * regionName=@"Select Region";
        if (isCitiesTxtFieldSelected==YES) {
            regionName=[[allCities objectAtIndex:row] objectForKey:@"cityName"];
        }
    else
    {
        regionName=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
    }
    
    return regionName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (isCitiesTxtFieldSelected==YES)
    {
        
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
        allCountries=[[NSArray alloc] initWithArray:dataRetreived ];
        allCountries=[[allCountries objectAtIndex:0] objectForKey:@"cities"];
        allCities=[[NSArray alloc] initWithArray:allCountries];
        allRegions=[[allCountries objectAtIndex:0] objectForKey:@"regions"];
        NSLog(@"countries %@",allCountries);
        NSLog(@"ciyies %@",allCities);
        NSLog(@"region %@",allRegions);
        
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

   // NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
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
        
        return NO;
    }
    else if (textField.tag == 2)
    {
        isCitiesTxtFieldSelected=NO;
        [[self pickerViewData ]reloadAllComponents];
        _pickerViewHeaderLabel.hidden=NO;
        _pickerViewHeaderBtn.hidden=NO;
        _pickerViewData.hidden=NO;
        
        return NO;
    }
    
    return YES;
    
}

- (IBAction)hidePickerViewBtn:(id)sender {
    _regionTxtField.text=selectedRegionName;
    _pickerViewHeaderLabel.hidden=YES;
    _pickerViewHeaderBtn.hidden=YES;
    _pickerViewData.hidden=YES;
}
-(UIBarButtonItem *) creatBackBotton
{
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    return myBackButton;
}

@end
