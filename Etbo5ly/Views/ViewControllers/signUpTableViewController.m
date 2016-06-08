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
- (void)viewDidLoad {
    [super viewDidLoad];
    userDetails=[[NSMutableDictionary alloc] init];
    [self addTextFieldBorderStyle:self.fullnameTxtField];
    [self addTextFieldBorderStyle:self.emailTxtField];
    [self addTextFieldBorderStyle:self.phoneTxtField];
    [self addTextFieldBorderStyle:self.regionTxtField];
    [self addTextFieldBorderStyle:self.cityTxtField];
    [self addTextFieldBorderStyle:self.passwordTxtField];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
}

-(void)handle:(id)dataRetreived :(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"signup"]) {
        NSString * result=dataRetreived;
        if ([result isEqualToString:@"true"]) {
             userDBFunctions=[[UserDAO alloc] initWithManagedObject];
            [userDBFunctions insertUser:newUser];
        }
    }
}
-(void)handleWithFailure:(NSError *)error
{
    NSLog(@"%@",error.userInfo);
}
- (IBAction)signUpBtn:(id)sender {
    
    networkDelegate=self;
    newUser=[[User alloc] initWithInfo];
    userRequestedServices=[[UserServices alloc] initWithNetworkDelegate:networkDelegate];
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
    
}
@end
