//
//  MenuItems.m
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "MenuItems.h"

@implementation MenuItems
-(id)initWithInfo
{
    self=[super init];
    return self;
}
-(id)initWithInfo:(int)itemId setNameEn:(NSString *)nameEn setPrice:(float)price setDescriptionEn:(NSString *)descriptionEn setItemRate:(int)itemRate setImageURL:(NSString *)imageURL
{
    if (self) {
        _itemId=itemId;
        _nameEn=nameEn;
        _price=price;
        _descriptionEn=descriptionEn;
        _itemRate=itemRate;
        _imageURL=imageURL;
    }
    return self;
}
-(NSMutableDictionary *)convertObjectToJSON:(MenuItems *)mealObject
{
    NSMutableDictionary *mealJSONObject=[[NSMutableDictionary alloc] init];
    [mealJSONObject setObject:[NSString stringWithFormat:@"%d",[mealObject itemId]] forKey:@"menuItemsItemId"];
    [mealJSONObject setObject:[mealObject nameEn] forKey:@"menuItemsNameEn"];
    [mealJSONObject setObject:[NSString stringWithFormat:@"%",[mealObject price] ] forKey:@"menuItemsPrice"];
    return mealJSONObject;
}
@end
