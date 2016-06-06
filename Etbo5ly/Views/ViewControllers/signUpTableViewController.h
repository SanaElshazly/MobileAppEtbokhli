//
//  signUpTableViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"

@interface signUpTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *signupTableView;

@property (strong, nonatomic) IBOutlet UIImageView *signupImg;


@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *fullnameTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *emailTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *phoneTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *regionTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *cityTxtField;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *passwordTxtField;
- (IBAction)signUpBtn:(id)sender;
//-(void) addTextFieldBorderStyle: (UITextField*) txtField;
-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField;
-(void) addImageViewBorderStyle: (UIImageView *) imgView;

@end
