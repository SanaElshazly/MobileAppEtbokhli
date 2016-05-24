//
//  CookServices.h
//  Etbo5ly
//
//  Created by MDW Event on 5/24/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etbo5lyNetworkDelegate.h"
#import "Etbo5lyNetworkManager.h"
#import "URLS.h"
#import "HomePageTableViewDataReloader.h"
@interface CookServices : NSObject <Etbo5lyNetworkDelegate>
{
    NSString * serviceName;
    NSString * serviceURL;
    NSMutableArray *cooks;
}
@property  HomePage* tableReloaderDelegate;
-(NSArray*) getCooksListDataService;
@end
