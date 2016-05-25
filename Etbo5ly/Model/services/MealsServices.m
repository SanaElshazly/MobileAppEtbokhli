//
//  MealsServices.m
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "MealsServices.h"

@implementation MealsServices 

-(id)initWithNetWorkDelegate:(Etbo5lyNetworkManager *)networkObj
{
    self=[super init];
    networkDelegateObj=networkObj;
    return self;
}
-(void) getMealsListDataService{
    serviceName=@"allMeals";
    serviceURL = [NSString stringWithFormat:@"%@",[URLS allMeals:-1]];
    NSLog(@"%@",serviceURL);
    
    [Etbo5lyNetworkManager connectGET:serviceURL setServiceName:serviceName setServiceNetworkManager:networkDelegateObj];
}

//-(void)handle:(id)dataRetreived :(NSString *)serviceName{
//    
//    NSLog(@"handle function");
//    if ([serviceName isEqualToString:@"allMeals"]) {
//        meals = [[NSMutableArray alloc] initWithArray:dataRetreived];
//    }
//    
//    NSLog(@"meals data %@", meals );
//    
//    //[self refreshDataInTableView];
//    
//}
//
//-(void)handleWithFailure:(NSError *)error{
//    NSLog(@"ERRORRRRR");
//}


@end
