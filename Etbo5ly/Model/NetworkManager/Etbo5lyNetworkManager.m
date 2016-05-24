//
//  Etbo5lyNetworkManager.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "Etbo5lyNetworkManager.h"


@implementation Etbo5lyNetworkManager

+(void)connectGET:(NSString *)url setServiceName:(NSString *)serviceName setServiceNetworkManager:(Etbo5lyNetworkManager *)networkManager
{
    myServiceName = serviceName;
    networkDelegate = networkManager;
    
    parameters = @{@"format": @"json"};
    
    
    requestURL = [NSURL URLWithString:url];
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:requestURL];
    
    [manager GET:requestURL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //_myData = [NSMutableData new]
        [networkDelegate handle : responseObject : myServiceName];
        
        NSLog(@"*******************************");
        
        //handle callback
        //self.movies=[[NSMutableArray alloc]initWithArray:responseObject];
        
        
        NSLog(@"NSMutableArray JSON");
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //handle with failure
        [networkDelegate handleWithFailure : error];
    }];
  
}


+(void)connectPOST:(NSString *)url :(NSString *)serviceName :(Etbo5lyNetworkManager*) networkManager{
    
    myServiceName = serviceName;
    networkDelegate = networkManager;
    
    parameters = @{@"format": @"json"};
    
    
    requestURL = [NSURL URLWithString:url];
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:requestURL];
    [manager POST:requestURL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //_myData = [NSMutableData new]
        [networkDelegate handle: responseObject :myServiceName];
        
        NSLog(@"*******************************");
        
        //handle callback
        //self.movies=[[NSMutableArray alloc]initWithArray:responseObject];
        
        
        NSLog(@"NSMutableArray JSON");
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //handle with failure
        [networkDelegate handleWithFailure : error];
    }];
    
}

@end
