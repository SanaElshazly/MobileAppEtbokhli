//
//  LocationPageViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 5/23/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "locationServices.h"
#import "Etbo5lyNetworkManager.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationPageViewController : UIViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate,CLLocationManagerDelegate,Etbo5lyNetworkDelegate>
{
    NSArray * allRegions;
    NSArray *allCities;
    NSArray *allCountries;
    locationServices * locationRequestedServices;
}
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewData;
- (IBAction)detectUserLocation:(id)sender;

@end
