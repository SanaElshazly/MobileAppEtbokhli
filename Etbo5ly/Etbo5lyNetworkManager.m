//
//  Etbo5lyNetworkManager.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "Etbo5lyNetworkManager.h"
#import "AFNetworking.h"

static NSString *myServiceName;

@implementation Etbo5lyNetworkManager

+(void)connect:(NSString *)url :(NSString *)serviceName :(Etbo5lyNetworkManager*) networkManager{
    
    myServiceName = serviceName;
    
    NSDictionary *parameters = @{@"format": @"json"};
    
    
    NSURL *requestURL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:requestURL];
    
    [manager GET:requestURL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //_myData = [NSMutableData new]
        //[_networkDelegate handle: _myData :myServiceName];
        
        NSLog(@"*******************************");
        
        
        //self.movies=[[NSMutableArray alloc]initWithArray:responseObject];
        
        
        NSLog(@"NSMutableArray JSON");
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //[_networkDelegate handle:nil :myServiceName];
    }];
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:networkManager];
    
    
    //[connection start];
    
    
    
    

    
    
}

@end
