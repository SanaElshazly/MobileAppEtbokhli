//
//  signUpTableViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "UserDAO.h"
#import "User.h"
#import "UserServices.h"
#import "Etbo5lyNetworkDelegate.h"
@interface signUpTableViewController : UITableViewController <UIPickerViewDelegate,UIPickerViewDataSource,Etbo5lyNetworkDelegate>
{
    NSMutableDictionary *userDetails;
    UserServices *userRequestedServices;
    UserDAO *userDBFunctions;
    User *newUser;
}
@property (strong, nonatomic) IBOutlet UITableView *signupTableView;

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *fullnameTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *emailTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *phoneTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *regionTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *cityTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *passwordTxtField;
@property (strong, nonatomic) IBOutlet UITableViewCell *cityCell;
- (IBAction)signUpBtn:(id)sender;
@property BOOL dataPickerViewIsShowingCities;
-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;
-(void) addImageViewBorderStyle: (UIImageView *) imgView;

@end
