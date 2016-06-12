//
//  ProfileViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "User.h"
#import "UserDAO.h"
#import "BasketTableViewController.h"


@interface ProfileViewController : UIViewController 
{
    UserDAO *userRequestedDBFunctions;
}

@property  User * userProfile;

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *profileFullNameTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *profileEmailTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *profilePhoneTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *profileAddressTxtField;


-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;

@end
