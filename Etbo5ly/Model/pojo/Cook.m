//
//  Cook.m
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "Cook.h"

@implementation Cook
-(id)initWithInfo
{
    self =[super init];
    return self;
}
-(id)initWithInfo:(int)userId setUserName:(NSString *)name setEmail:(NSString *)email setPassword:(NSString *)password setRegisterationDate:(NSDate *)registerationDate setPhone:(NSString *)phone setAddress:(NSString *)address setLongitude:(double)longitude setLatitude:(double)latitude setStartWorkingHours:(NSDate *)startWorkingHours setEndWorkingHours:(NSDate *)endWorkingHours
{
    return self;
}

@end
