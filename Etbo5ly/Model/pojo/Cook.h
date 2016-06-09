//
//  Cook.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "MenuItems.h"
@class MenuItems;
@interface Cook : User
@property NSDate *startWorkingHours;
@property NSDate * endWorkingHours;
@property NSSet<MenuItems*> *menu_items;

-(id)initWithInfo;
-(id)initWithInfo:(int)userId setUserName:(NSString *)name setEmail:(NSString *)email setPassword:(NSString *)password setRegisterationDate:(NSDate *)registerationDate setPhone:(NSString *)phone setAddress:(NSString *)address setLongitude:(double)longitude setLatitude:(double)latitude setStartWorkingHours:(NSDate*)startWorkingHours setEndWorkingHours : (NSDate*)endWorkingHours;
@end
