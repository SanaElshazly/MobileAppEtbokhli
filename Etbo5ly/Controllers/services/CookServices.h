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
@interface CookServices : NSObject 
{
    NSString * serviceName;
    NSString * serviceURL;
    Etbo5lyNetworkManager *networkDelegateObj;
}
-(void) getCooksListDataService;
-(void) getCooksBasedOnLocation : (double) latitude setLongitude : (double) longitude;
-(void) getCooksByRegion : (int) regionID;

-(void) getCookCategories : (int) cookID;
-(void) getCookCategoryMeals:(int) cookID : (int) categoryID;


-(id) initWithNetworkDelegate : (Etbo5lyNetworkManager*) networkManagerObj;
@end
