//
//  UserServices.m
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "UserServices.h"

@implementation UserServices
-(id)initWithNetworkDelegate:(Etbo5lyNetworkManager *)networkManagerObj
{
    self=[super init];
    networkDelegateObj=networkManagerObj;
    return self;
}
-(void)createOrder:(NSDictionary *)jsonParameters
{
    serviceName=@"createOrder";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS createOrder]];
    NSLog(@"%@",serviceURL);
    [Etbo5lyNetworkManager connectPOST:serviceURL :serviceName :networkDelegateObj setParameters:jsonParameters];
}
-(void)signUP:(NSDictionary *)userJSON
{
    serviceName=@"signup";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS signUp]];
    NSLog(@"%@",serviceURL);
    [Etbo5lyNetworkManager connectPOST:serviceURL :serviceName :networkDelegateObj setParameters:userJSON];
}
-(void)login:(NSDictionary *)userLognInJSON
{
    serviceName=@"login";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS login]];
    NSLog(@"%@",serviceURL);
    [Etbo5lyNetworkManager connectPOST:serviceURL :serviceName :networkDelegateObj setParameters:userLognInJSON];
}
-(void)getAllNonRatedOrders:(int)userId
{
    serviceName=@"nonRatedOrders";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS getNonRatingOrder:userId]];
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];

}
-(void)getAllOrders:(int)userId
{
    serviceName=@"allOrders";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS getAllOrderHistory:userId]];
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];
}
-(void)rateOrder:(NSDictionary *)orderRateJSON
{
    serviceName=@"rateOrder";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS rateOrder]];
    NSLog(@"%@",serviceURL);
    [Etbo5lyNetworkManager connectPOST:serviceURL :serviceName :networkDelegateObj setParameters:orderRateJSON];
}
@end
