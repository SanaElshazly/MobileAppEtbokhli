//
//  LoginViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/5/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "signUpTableViewController.h"
#import "Order.h"
@interface LoginViewController : UIViewController <Etbo5lyNetworkDelegate,UITextFieldDelegate
>
{
    UserServices *userRequestedServices;
    NSMutableDictionary *userJSON;
    User * loggedInUser;
    UserDAO *userDBfunctions;
}
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *loginEmailTxtField;

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *loginPasswordTxtField;
@property Order * orderCookDetails;
@property NSArray *orderToCheckedOut;

- (IBAction)createAccountBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;

-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;

@end
