//
//  MenuItems.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cook.h"
@interface MenuItems : NSObject
@property int itemId;
@property NSString * nameEn;
@property float price;
@property NSString * descriptionEn;
@property int itemRate;
@property NSString * imageURL;
@property NSString *cookName;
-(id) initWithInfo;
-(id) initWithInfo : (int) itemId setNameEn : (NSString*) nameEn setPrice : (float) price setDescriptionEn : (NSString*) descriptionEn setItemRate : (int) itemRate setImageURL : (NSString*) imageURL;
-(NSMutableDictionary *) convertObjectToJSON : (MenuItems *) mealObject;
@end
