//
//  Etbo5lyNetworkManager.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etbo5lyNetworkDelegate.h"

static id<Etbo5lyNetworkDelegate> networkDelegate;
@interface Etbo5lyNetworkManager : NSObject


@property NSMutableData *myData;


//@property id<Etbo5lyNetworkDelegate> networkDelegate;


+(void) connect:(NSString*) url : (NSString*) serviceName :(Etbo5lyNetworkManager*) networkManager;



@end
