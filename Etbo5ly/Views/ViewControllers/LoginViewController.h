//
//  LoginViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/5/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *loginEmailTxtField;

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *loginPasswordTxtField;



- (IBAction)createAccountBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;

-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;

@end
