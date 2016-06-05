//
//  Order.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property int orderID;
@property NSString *location;
@property int duration;
@property NSString * orderComment;
@property int cookRating;
@property NSString * cookComment;
@property NSString * type;
@property double longitude;
@property double latitude;
@property NSString * addressDetails;
@property int regionId;
@property NSString *cookName;
@property float orderTotalPrice;
-(id) initWithInfo;
-(id) initWithInfo : (int) orderID setLocation : (NSString*) location setDuration : (int) duration setOrderComment : (NSString * ) orderComment setCookRating : (int) cookRating setCookComment : (NSString*) cookComment setType : (NSString *)type setLongitude : (double) longitude setLatitude : (double) latitude;
+(NSMutableDictionary *) convertOrderToJSON : (Order *) orderObject;
@end
