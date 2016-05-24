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
-(instancetype)init
{
    NSLog(@"get f constr");
    self=[super init];
    
    networkDelegate=self;
    return self;
}
-(NSArray*) getCooksListDataService {
    NSLog(@"d5l fun get cooks");
    serviceName=@"allCooks";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS allCooks:-1]];
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegate];
    return cooks;
}
-(void)handle:(id)dataRetreived :(NSString *)serviceName{
    NSLog(@"handle object");
    if ([serviceName isEqualToString:@"allCooks"]) {
        cooks = [[NSMutableArray alloc] initWithArray:dataRetreived];
    }
}

-(void)handleWithFailure:(NSError *)error{
    NSLog(@"ERRORRRRR");
}
@end