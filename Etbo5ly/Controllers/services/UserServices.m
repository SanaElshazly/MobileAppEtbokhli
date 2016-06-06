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
    
 //   [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegateObj];
    [Etbo5lyNetworkManager connectPOST:serviceURL :serviceName :networkDelegateObj setParameters:jsonParameters];
}
@end
