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
#import "BasketTableViewController.h"
#import "User.h"
#import "UserDAO.h"
#import "Order.h"
#import "UserServices.h"
#import "SCLAlertView.h"
@interface orderAddressDetailsTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,Etbo5lyNetworkDelegate>
{
    UserServices *userRequestedServices;
    locationServices * locationRequestedService;
    NSMutableArray * allRegions;
    NSMutableArray *allCities;
    NSArray *allCountries;
    UserDAO *requestedUserDBFunvtions;
    User * registeredUser;
}
@property Order * orderCookDetails;
@property NSArray *orderDetails;
@property NSDictionary * orderJSONParameters;;
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
@property (strong, nonatomic) IBOutlet UILabel *totalOrderPrice;
@property (strong, nonatomic) IBOutlet UIButton *placeOrderBtnOutlet;

@end
