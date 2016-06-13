//
//  UserServices.h
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etbo5lyNetworkDelegate.h"
#import "Etbo5lyNetworkManager.h"
#import "URLS.h"
@interface UserServices : NSObject
{
    NSString * serviceName;
    NSString * serviceURL;
    Etbo5lyNetworkManager *networkDelegateObj;
}
-(void) createOrder : (NSDictionary *) jsonParameters;
-(id) initWithNetworkDelegate : (Etbo5lyNetworkManager*) networkManagerObj;
-(void) signUP:(NSDictionary *) userJSON;
-(void) login :(NSDictionary *) userLognInJSON;
-(void) getAllNonRatedOrders : (int) userId;
-(void) getAllOrders : (int) userId;
-(void) rateOrder : (NSDictionary *) orderRateJSON;
@end