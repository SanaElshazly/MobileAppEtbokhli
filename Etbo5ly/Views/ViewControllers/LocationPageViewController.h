//
//  LocationPageViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 5/23/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "locationServices.h"
#import "CookServices.h"
#import "Etbo5lyNetworkManager.h"
#import <CoreLocation/CoreLocation.h>
#import "HomePageTableViewController.h"
#import "CooksBasedOnLocationTableViewController.h"
static NSMutableArray * allRegions;
static NSMutableArray *allCities;
static NSArray *allCountries;
@interface LocationPageViewController : UIViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate,CLLocationManagerDelegate,Etbo5lyNetworkDelegate>
{

    locationServices * locationRequestedServices;
    CookServices * cooksRequestedServices;
    double userLatitude;
    double userLongitude;
    NSArray * cooksBasedLocation;
    BOOL isCitiesTxtFieldSelected;
    
}
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewData;
@property BOOL didGetLocation;
- (IBAction)detectUserLocation:(id)sender;
- (IBAction)getAllCooksByRegion:(id)sender;
-(void) getAllRegionsAndCities;
@property (strong, nonatomic) IBOutlet UITextField *regionTxtField;
@property (strong, nonatomic) IBOutlet UITextField *cityTxtField;
@property (strong, nonatomic) IBOutlet UILabel *pickerViewHeaderLabel;
@property (strong, nonatomic) IBOutlet UIButton *pickerViewHeaderBtn;
- (IBAction)hidePickerViewBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *showCooksBtn;


@end
