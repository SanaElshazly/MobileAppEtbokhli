//
//  ProfileViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


-(void) viewDidLayoutSubviews {
    [self addTextFieldBorderStyle: _profileFullNameTxtField];
    [self addTextFieldBorderStyle: _profileEmailTxtField];
    [self addTextFieldBorderStyle: _profilePhoneTxtField];
    [self addTextFieldBorderStyle: _profileAddressTxtField];
    
    _profileFullNameTxtField.text = _userProfile.name;
    _profileFullNameTxtField.userInteractionEnabled = NO;
    
    _profileEmailTxtField.text = _userProfile.email;
    _profileEmailTxtField.userInteractionEnabled = NO;
    
    _profilePhoneTxtField.text = _userProfile.phone;
    _profilePhoneTxtField.userInteractionEnabled = NO;
    
    _profileAddressTxtField.text = _userProfile.address;
    _profileAddressTxtField.userInteractionEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userRequestedDBFunctions=[[UserDAO alloc] initWithManagedObject];
    _userProfile= [userRequestedDBFunctions selectRegisteredUser];
    
    //NSLog(@"%@",registeredUser.email);
    if (_userProfile.email==(id) [NSNull null]||_userProfile.email.length==0) {
        NSLog(@"Error");
        UIStoryboard *storyboard=self.navigationController.storyboard;
        LoginViewController *loginViewController=[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    else
    {
        [self viewDidLayoutSubviews];
        
    }

    // Do any additional setup after loading the view.
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField{//:(UITextField*) txtField{
    
    CALayer *bottomBorder = [CALayer layer];
    CGFloat borderWidth = 1;
    bottomBorder.borderWidth = borderWidth;
    bottomBorder.borderColor = [[UIColor orangeColor]CGColor];
    
    bottomBorder.frame = CGRectMake(0.0f, txtField.frame.size.height - borderWidth, txtField.frame.size.width,txtField.frame.size.height);
    bottomBorder.backgroundColor = [UIColor orangeColor].CGColor;
    txtField.floatLabelPassiveColor = [UIColor orangeColor];
    [txtField.layer addSublayer:bottomBorder];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
