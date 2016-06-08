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
    _cityTxtField.delegate=self;
    values=[[NSArray alloc] initWithObjects:@"noha",@"mai", nil];
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
-(void) showCityPickerCell
{
    self.dataPickerViewIsShowingCities=YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    self.citiesPickerView.hidden=NO;
    self.citiesPickerView.alpha=0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.citiesPickerView.alpha=1.0f;
    }];
}
-(void) hideDataPickerCell
{
    self.dataPickerViewIsShowingCities=NO;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        self.citiesPickerView.alpha=0.0f;
    }
                     completion:^(BOOL fininshed){
                         self.citiesPickerView.hidden=YES;
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 && indexPath.row==4 && self.dataPickerViewIsShowingCities==NO)
    {
        [self hideDataPickerCell];
        return 0.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"nohnohergter");
    UITableViewCell *cellClicked=[self.tableView cellForRowAtIndexPath:indexPath];
    if (cellClicked==_cityCell) {
        NSLog(@"nohnoh");
    }
    if (indexPath.section==0 && indexPath.row==3) {
        if(self.dataPickerViewIsShowingCities)
        {
            [self hideDataPickerCell];
        }
        else
        {
            [self showCityPickerCell];
        }
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    int arrCount=0;
    if (component==0) {
            arrCount=values.count;
        
    }
    
    return arrCount;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *data=[values objectAtIndex:row];
    return data;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        NSLog(@"hwll");
        if(self.dataPickerViewIsShowingCities)
        {
            [self hideDataPickerCell];
        }
        else
        {
            [self showCityPickerCell];
        }
        return NO;
    }
    return YES;
}

- (IBAction)signUpBtn:(id)sender {
    User *newUser=[[User alloc] initWithInfo];
    newUser.email=_emailTxtField.text;
    newUser.name=_fullnameTxtField.text;
    newUser.password=_passwordTxtField.text;
    newUser.tybe=@"user";
    UserDAO *userDBFunctions=[[UserDAO alloc] initWithManagedObject];
    [userDBFunctions insertUser:newUser];
    
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
