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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackground-27.png"]]];
    [self addTextFieldBorderStyle:self.loginEmailTxtField];
    [self addTextFieldBorderStyle:self.loginPasswordTxtField];
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
- (IBAction)loginBtn:(id)sender {
    networkDelegate=self;
    [userJSON setObject:_loginEmailTxtField.text forKey:@"email"];
    [userJSON setObject:_loginPasswordTxtField.text forKey:@"password"];
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
    [userRequestedServices login:userJSON];
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
            [self.tabBarController setSelectedIndex:0];
        }

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
