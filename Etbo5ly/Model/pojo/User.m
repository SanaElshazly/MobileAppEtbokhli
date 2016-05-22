//
//  User.m
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithInfo
{
    self = [super init];
    return self;
}
-(id)initWithInfo:(int)userId setUserName:(NSString *)name setEmail:(NSString *)email setPassword:(NSString *)password setRegisterationDate:(NSDate *)registerationDate setPhone:(NSString *)phone setAddress:(NSString *)address setLongitude:(double)longitude setLatitude:(double)latitude
{
    self = [super init];
    if (self) {
        _userId=userId;
        self.name=name;
        _email=email;
        _password=password;
        _registerationDate=registerationDate;
        _phone=phone;
        _address=address;
        _longitude=longitude;
        _latitude=latitude;
    }
    return self;
}
@end
