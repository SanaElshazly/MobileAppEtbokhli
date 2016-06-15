//
//  signUpTableViewController.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/4/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "signUpTableViewController.h"

@interface signUpTableViewController ()

@end

@implementation signUpTableViewController
{
    NSArray *values;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _phoneTxtField.delegate=self;
    _emailTxtField.delegate=self;
    _passwordTxtField.delegate=self;
    _fullnameTxtField.delegate=self;
    _cityTxtField.delegate=self;
    _regionTxtField.delegate=self;
    [self addTextFieldBorderStyle:self.fullnameTxtField];
    [self addTextFieldBorderStyle:self.emailTxtField];
    [self addTextFieldBorderStyle:self.phoneTxtField];
    [self addTextFieldBorderStyle:self.regionTxtField];
    [self addTextFieldBorderStyle:self.cityTxtField];
    [self addTextFieldBorderStyle:self.passwordTxtField];
}

-(BOOL) textFieldShouldReturn : (UITextField*) textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    userDetails=[[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [self viewDidLayoutSubviews];
}

-(BOOL) vaidateFullName
{
   if (_fullnameTxtField.text.length<3)
    {
        _fullnameTxtField.placeholder=@"enter a valid name";
        _fullnameTxtField.textColor=[UIColor redColor];
        return NO;
    }
    else
    {
        return YES;
    }
}
-(BOOL) validatePhone
{
    if (_phoneTxtField.text.length<10)
    {
        _phoneTxtField.placeholder=@"enter a valid phone number";
        _phoneTxtField.textColor=[UIColor redColor];
        return NO;
    }
    else
        return YES;
}
-(BOOL) validatePassword
{
    if (_passwordTxtField.text.length<5)
    {
        _passwordTxtField.placeholder=@"enter a valid password";
        _passwordTxtField.textColor=[UIColor redColor];
        return NO;
    }
    else
        return YES;
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
-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"signup"]) {
        NSLog(@"%@",[dataRetreived valueForKey:@"id"]);
        newUser.userId=[[dataRetreived valueForKey:@"id"] integerValue];
        userDBFunctions=[[UserDAO alloc] initWithManagedObject];
        [userDBFunctions insertUser:newUser];
        if ([BasketTableViewController changeValue]==YES) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@,",newUser.name] message:@"You have successfully registered" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            UIStoryboard *storyboard=self.navigationController.storyboard;
            orderAddressDetailsTableViewController * orderAddress=[storyboard instantiateViewControllerWithIdentifier:@"orderAddress"];
            [orderAddress setOrderDetails:_orderToCheckedOut];
            [orderAddress setOrderCookDetails:_orderCookDetails];
            [self.navigationController pushViewController:orderAddress animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@,",newUser.name] message:@"You have successfully registered" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.tabBarController setSelectedIndex:0];
        }
        
        
    }
}
-(void)handleWithFailure:(NSError *)error
{
    if (error.code==-1011||error.code==-2102 || error.code==-1004) {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    NSLog(@"%@",error.userInfo);
}
- (IBAction)signUpBtn:(id)sender {
    networkDelegate=self;
    if (![self NSStringIsValidEmail:_emailTxtField.text]) {
        _emailTxtField.placeholder=@"Please enter a valid email";
        _emailTxtField.textColor=[UIColor redColor];
        
            
        }
    else if ([self vaidateFullName]&&[self validatePhone]&&[self validatePassword]) {
        newUser=[[User alloc] initWithInfo];
        userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
        NSLog(@"%d",newUser.userId);
        newUser.email=_emailTxtField.text;
        newUser.name=_fullnameTxtField.text;
        newUser.password=_passwordTxtField.text;
        newUser.phone=_phoneTxtField.text;
        newUser.regionID=3;
        newUser.address=[NSString stringWithFormat:@"%@%@", _cityTxtField.text,_regionTxtField.text];
        newUser.tybe=@"user";
        
        [userDetails setObject:newUser.email forKey:@"email"];
        [userDetails setObject:newUser.name forKey:@"name"];
        [userDetails setObject:newUser.password forKey:@"password"];
        [userDetails setObject:newUser.phone forKey:@"phone"];
        [userDetails setObject:newUser.address forKey:@"address"];
        [userDetails setObject:[NSNumber numberWithInt:newUser.regionID] forKey:@"regionId"];
        [userRequestedServices signUP:userDetails];

    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag==2) {
        textField.placeholder=@"Email";
    }
    else if (textField.tag==1)
    {
        textField.placeholder=@"Full Name";
    }
    else if (textField.tag==3)
    {
        _phoneTxtField.placeholder=@"Phone";
        _phoneTxtField.textColor=[UIColor blackColor];
    }
    else if (textField.tag==6)
    {
        textField.placeholder=@"Password";
    }
    textField.textColor=[UIColor blackColor];
    return YES;
}
-(void) addImageViewBorderStyle: (UIImageView *) imgView{
    imgView.layer.cornerRadius =10.0f;
    imgView.layer.borderColor = [[UIColor orangeColor] CGColor];
    imgView.layer.borderWidth =1.0f;
    imgView.layer.masksToBounds = YES;
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
    txtField.layer.masksToBounds = YES;
    
    
}
-(void) changeTextFieldBorderColor : (UIFloatLabelTextField *)txtField
{
}
- (IBAction)cancelSignUp:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
