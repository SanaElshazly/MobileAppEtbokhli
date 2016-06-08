//
//  orderAddressDetailsTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/8/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "locationServices.h"
#import "Etbo5lyNetworkDelegate.h"
@interface orderAddressDetailsTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate,Etbo5lyNetworkDelegate>
{
    locationServices * locationRequestedService;
    NSMutableArray * allRegions;
    NSMutableArray *allCities;
    NSArray *allCountries;
}
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *cityTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *regionTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *streetTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *buildingNumberTxtField;

- (IBAction)placeOrderBtn:(id)sender;
-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;
@property BOOL dataPickerViewIsShowingCities;
@property BOOL dataPickerViewIsShowingRegions;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewCities;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewRegions;

@end
