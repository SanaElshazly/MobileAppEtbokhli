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
    allRegions=@[@{@"regionName":@"shoubra"},@{@"regionName":@"El Haram"},@{@"regionName":@"El Maadi"},@{@"regionName":@"Nasr City"}];
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
        arrCount=allRegions.count;
    }
    
    return arrCount;
}
-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * regionName;
    if (component==0) {
        regionName=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
    }
    return regionName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    regionID=[[[allRegions objectAtIndex:row] objectForKey:@"regionId"] integerValue];
    selectedRegionName=[[allRegions objectAtIndex:row] objectForKey:@"regionName"];
    NSLog(@"%d",regionID);
}
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    CooksBasedOnLocationTableViewController *cooksBasedOnLocationTableViewController;
    if ([serviceName isEqualToString:@"allRegionsWithCountries"]) {
        allCountries=[[NSArray alloc] initWithArray:dataRetreived ];
        allCountries=[[allCountries objectAtIndex:0] objectForKey:@"cities"];
        allCities=[[NSArray alloc] initWithArray:allCountries];
        allRegions=[[allCountries objectAtIndex:0] objectForKey:@"regions"];
        NSLog(@"countries %@",allCountries);
        NSLog(@"ciyies %@",allCities);
        NSLog(@"region %@",allRegions);
        [[self pickerViewData ]reloadAllComponents];
    }
    else if ([serviceName isEqualToString:@"allCooksBasedOnLocation"])
    {
        cooksBasedLocation=[[NSArray alloc] initWithArray:dataRetreived];
        cooksBasedOnLocationTableViewController=[CooksBasedOnLocationTableViewController new];
        [cooksBasedOnLocationTableViewController setCooksOnLocation:cooksBasedLocation];
        [[self navigationController] pushViewController:cooksBasedOnLocationTableViewController animated:YES];
    }
    else if ([serviceName isEqualToString:@"cooksByRegion"])
    {
        cooksBasedLocation=[[NSArray alloc] initWithArray:dataRetreived];
        cooksBasedOnLocationTableViewController=[CooksBasedOnLocationTableViewController new];
        [cooksBasedOnLocationTableViewController setCooksOnLocation:cooksBasedLocation];
        [[self navigationController] pushViewController:cooksBasedOnLocationTableViewController animated:YES];
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
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    crnLoc = [CLLocation alloc];
//    crnLoc = [locations lastObject];
//   NSLog(@"latitude %@",[NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude]);
//   [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
//}
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
//    [locationManager startUpdatingLocation];
//    [cooksRequestedServices getCooksBasedOnLocation:userLatitude setLongitude:userLongitude];
    [locationManager startUpdatingLocation];
   
}

- (IBAction)getAllCooksByRegion:(id)sender {
    NSLog(@"dost");
    [cooksRequestedServices getCooksByRegion:regionID];
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        NSLog(@"hgf");
        _pickerViewHeaderLabel.hidden=NO;
        _pickerViewHeaderBtn.hidden=NO;
        _pickerViewData.hidden=NO;
        
        return NO;
    }
    
    return YES;
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"locationBasedCooks"])
//    {
//        [cooksRequestedServices getCooksBasedOnLocation:userLatitude setLongitude:userLongitude];
//        CooksBasedOnLocationTableViewController *cooksBasedOnLocationTableViewController=[segue destinationViewController];
//        [cooksBasedOnLocationTableViewController setCooksOnLocation:cooksBasedLocation];
//    }
//}
- (IBAction)hidePickerViewBtn:(id)sender {
    _regionTxtField.text=selectedRegionName;
    _pickerViewHeaderLabel.hidden=YES;
    _pickerViewHeaderBtn.hidden=YES;
    _pickerViewData.hidden=YES;
}
@end
