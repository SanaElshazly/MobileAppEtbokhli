//
//  CookServices.m
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "CookServices.h"
#import "HomePageTableViewController.h"
@implementation CookServices
-(id)initWithNetworkDelegate:(Etbo5lyNetworkManager*)networkManagerObj
{
    self=[super init];
    networkDelegateObj=networkManagerObj;
    return self;
}
-(void) getCooksListDataService {
    NSLog(@"d5l fun get cooks");
    serviceName=@"allCooks";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS allCooks:-1]];
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegateObj];
}
@end