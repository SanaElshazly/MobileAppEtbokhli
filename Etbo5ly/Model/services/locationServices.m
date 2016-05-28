//
//  locationServices.m
//  Etbo5ly
//
//  Created by MDW Event on 5/25/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "locationServices.h"

@implementation locationServices
-(id)initWithNetworkDelegate:(Etbo5lyNetworkManager *)networkManagerObj
{
    self=[super init];
    networkDelegateObj=networkManagerObj;
    return self;
}
-(void)getAllRegions
{
    serviceName=@"allRegionsWithCountries";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS countriesWithRegions]];
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegateObj];
}
@end
