//
//  orderAddressTableViewController.h
//  Etbo5ly
//
//  Created by ITI on 6/7/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPageViewController.h"
@interface orderAddressTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIPickerView *citiesPickerView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property BOOL dataPickerViewIsShowingCities;
@end
