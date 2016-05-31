//
//  Etbo5lyNetworkManager.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etbo5lyNetworkDelegate.h"
#import "AFNetworking.h"


static id<Etbo5lyNetworkDelegate> networkDelegate;
static NSString *myServiceName;
static AFHTTPRequestOperationManager *manager;
static NSURL *requestURL ;
static NSDictionary *parameters;

@interface Etbo5lyNetworkManager : NSObject

//@property NSMutableData *myData;
//@property id<Etbo5lyNetworkDelegate> networkDelegate;



+(void) connectGET:(NSString*) url setServiceName: (NSString*) serviceName setServiceNetworkManager:(Etbo5lyNetworkManager*) networkManager;

+(void) connectPOST:(NSString*) url : (NSString*) serviceName :(Etbo5lyNetworkManager*) networkManager;


@end
