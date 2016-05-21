//
//  Cook.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Cook : User
@property NSDate *startWorkingHours;
@property NSDate * endWorkingHours;
-(id)initWithInfo;
-(id) initWithInfo:(int)userId :(id)setUserName :(NSString *)name :(id)setEmail :(NSString *)email :(id)setPassword :(NSString *)password :(id)setRegisterationDate :(NSDate *)registerationDate :(id)setPhone :(NSString *)phone :(id)setAddress :(NSString *)address :(id)setLongitude :(double)longitude :(id)setLatitude :(double)latitude : setStartWorkingHours : (NSDate *) startWorkingHours : setEndWorkingHours : (NSDate *) endWorkingHours;
@end
