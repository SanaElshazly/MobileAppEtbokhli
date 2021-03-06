//
//  LoginViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/5/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
   
    [self addTextFieldBorderStyle:self.loginEmailTxtField];
    [self addTextFieldBorderStyle:self.loginPasswordTxtField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginPasswordTxtField.delegate=self;
    _loginEmailTxtField.delegate=self;
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackground-27.png"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createAccountBtn:(id)sender {

}
-(void)viewDidAppear:(BOOL)animated
{
    userJSON=[[NSMutableDictionary alloc] init];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"createAccount"]) {
        signUpTableViewController *signupController=(signUpTableViewController*)[segue destinationViewController];
        [signupController setOrderToCheckedOut:_orderToCheckedOut];
        [signupController setOrderCookDetails:_orderCookDetails];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    if (textField.tag==1) {
        textField.placeholder=@"Email";
    }
    
    textField.textColor=[UIColor blackColor];
    return YES;
}
- (IBAction)loginBtn:(id)sender {
    networkDelegate=self;
        if (![_loginEmailTxtField.text isEqualToString:@""]&&[self NSStringIsValidEmail:_loginEmailTxtField.text]) {
            [userJSON setObject:_loginEmailTxtField.text forKey:@"email"];
            [userJSON setObject:_loginPasswordTxtField.text forKey:@"password"];
            userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
            [userRequestedServices login:userJSON];
        }
        else {
            _loginEmailTxtField.placeholder=@"Please enter a valid email";
            _loginEmailTxtField.textColor=[UIColor redColor];
        }
    
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//aljazayeerly@gmail.com
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"login"]) {
        loggedInUser=[[User alloc] init];
        userDBfunctions=[[UserDAO alloc] initWithManagedObject];
        loggedInUser.userId=[[dataRetreived valueForKey:@"id"] integerValue];
        loggedInUser.name=[dataRetreived valueForKey:@"name"];
        loggedInUser.email=[dataRetreived valueForKey:@"email"];
        loggedInUser.password=[dataRetreived valueForKey:@"password"];
        loggedInUser.phone=[dataRetreived valueForKey:@"phone"];
        loggedInUser.tybe=@"user";
        loggedInUser.regionID=3;
        [userDBfunctions insertUser:loggedInUser];
        if ([BasketTableViewController changeValue]==YES) {
            UIStoryboard *storyboard=self.navigationController.storyboard;
            orderAddressDetailsTableViewController * orderAddress=[storyboard instantiateViewControllerWithIdentifier:@"orderAddress"];
            [orderAddress setOrderDetails:_orderToCheckedOut];
            [orderAddress setOrderCookDetails:_orderCookDetails];
            [self.navigationController pushViewController:orderAddress animated:YES];
        }
        else
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            //[self.tabBarController setSelectedIndex:0];
        }

    }
}
-(BOOL) validateUserInput
{
    if ([_loginEmailTxtField.text isEqualToString:@""] ) {
        _loginEmailTxtField.text=@"Please enter a valid email";
        _loginEmailTxtField.textColor=[UIColor redColor];
    }
    return NO;
}
-(BOOL) textFieldShouldReturn : (UITextField*) textField
{
    [_loginEmailTxtField resignFirstResponder];
    [_loginPasswordTxtField resignFirstResponder];
    return YES;
}
-(void)handleWithFailure:(NSError *)error
{
    NSLog(@"errooor yallahwii %d%@",error.code,error.userInfo);
    if (error.code==-1011) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Incorrect email or password" message:@" Please Check youe email , password and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (error.code==-2102 || error.code==-1004)
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void) addTextFieldBorderStyle: (UIFloatLabelTextField*) txtField{//:(UITextField*) txtField{
    
    CALayer *bottomBorder = [CALayer layer];
    CGFloat borderWidth = 1;
    bottomBorder.borderWidth = borderWidth;
    bottomBorder.borderColor = [[UIColor orangeColor]CGColor];
    
    bottomBorder.frame = CGRectMake(0.0f, txtField.frame.size.height - borderWidth, txtField.frame.size.width,txtField.frame.size.height);
    bottomBorder.backgroundColor = [UIColor orangeColor].CGColor;
    txtField.floatLabelActiveColor = [UIColor orangeColor];
    [txtField.layer addSublayer:bottomBorder];
    
}
@end
