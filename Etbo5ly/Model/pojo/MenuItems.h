//
//  MenuItems.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cook.h"
#import "CategoryDTO.h"
#import "OrderDetails.h"
@class CategoryDTO;
@class Cook;
@class OrderDetails;
@interface MenuItems : NSObject
@property int itemId;
@property int cookId;
@property NSString * nameEn;
@property float price;
@property NSString * descriptionEn;
@property int itemRate;
@property NSString * imageURL;
@property NSString *cookName;
@property int quantity;
@property float totalPrice;
@property NSString *comment;
@property int rating;
@property NSString * nameAr;
@property NSString * descriptionAr;
@property float totalItemPrice;
@property Cook *cook;
@property NSSet <CategoryDTO*> *categories;
@property NSSet<OrderDetails*> *menuItems_OrderDetails;
-(id) initWithInfo;
-(id) initWithInfo : (int) itemId setNameEn : (NSString*) nameEn setPrice : (float) price setDescriptionEn : (NSString*) descriptionEn setItemRate : (int) itemRate setImageURL : (NSString*) imageURL;
+(NSMutableDictionary *) convertObjectToJSON : (MenuItems *) mealObject;
@end
