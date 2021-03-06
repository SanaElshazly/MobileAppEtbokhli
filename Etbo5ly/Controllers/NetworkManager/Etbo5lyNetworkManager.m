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
    manager = [AFHTTPRequestOperationManager manager] ;

    NSLog(@"%@%@",serviceName,url);
    
    [manager GET:requestURL.absoluteString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [networkDelegate handle : responseObject : myServiceName];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //NSLog(@"Error: %@", error);
                NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                //handle with failure
                [networkDelegate handleWithFailure : error];
        NSLog(@"Error: %@", error);
    }];

}
+(void)connectPOST:(NSString *)url :(NSString *)serviceName :(Etbo5lyNetworkManager *)networkManager setParameters:(NSDictionary *)methodParameters
{
    parameters=[[NSDictionary alloc] init];
    myServiceName = serviceName;
    networkDelegate = networkManager;
    parameters = methodParameters;
    NSLog(@"paraaameteers%@",parameters);
    requestURL = [NSURL URLWithString:url];
    manager=[AFHTTPRequestOperationManager manager] ;
  //  manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",nil];
   manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:requestURL.absoluteString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [networkDelegate handle : responseObject : myServiceName];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        //handle with failure
        [networkDelegate handleWithFailure : error];
        NSLog(@"Error: %@", error);
    }];
}
@end
