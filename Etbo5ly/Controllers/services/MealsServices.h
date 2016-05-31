//
//  MealsServices.h
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etbo5lyNetworkDelegate.h"
#import "Etbo5lyNetworkManager.h"
#import "URLS.h"

@interface MealsServices : NSObject
{
    NSString * serviceName;
    NSString * serviceURL;
    Etbo5lyNetworkManager *networkDelegateObj;

}

-(void) getMealsListDataService;
-(id) initWithNetWorkDelegate : (Etbo5lyNetworkManager *) networkObj;
@end
