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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    networkDelegate=self;
    locationManager = [[CLLocationManager alloc]init];
    locationRequestedServices=[[locationServices alloc] initWithNetworkDelegate:networkDelegate];
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
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"allRegionsWithCountries"]) {
        allCountries=[[NSArray alloc] initWithArray:dataRetreived ];
        allCountries=[[allCountries objectAtIndex:0] objectForKey:@"cities"];
        allCities=[[NSArray alloc] initWithArray:allCountries];
        allRegions=[[allCountries objectAtIndex:0] objectForKey:@"regions"];
    }
    NSLog(@"countries %@",allCountries);
    NSLog(@"ciyies %@",allCities);
    NSLog(@"region %@",allRegions);
    [[self pickerViewData ]reloadAllComponents];
}
-(void)handleWithFailure:(NSError *)error
{
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    crnLoc = [CLLocation alloc];
    crnLoc = [locations lastObject];
   NSLog(@"latitude %@",[NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude]);
   [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error.description);
}
- (IBAction)detectUserLocation:(id)sender {
    NSLog(@"h");
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate =self; 
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
@end
