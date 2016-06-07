//
//  User.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property int userId;
@property NSString * name;
@property NSString * email;
@property NSString * password;
@property NSDate * registerationDate;
@property NSString * phone;
@property NSString * address;
@property NSString * tybe;

@property double longitude;
@property double latitude;
@property NSString * imageURL;
-(id) initWithInfo;
-(id) initWithInfo : (int) userId  setUserName : (NSString *) name  setEmail : (NSString * ) email setPassword : (NSString *) password setRegisterationDate : (NSDate *) registerationDate setPhone : (NSString *) phone  setAddress : (NSString *) address  setLongitude : (double) longitude  setLatitude : (double) latitude;

@end
