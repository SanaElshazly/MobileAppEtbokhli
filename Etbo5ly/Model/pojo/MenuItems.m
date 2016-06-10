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
+(NSMutableDictionary *)convertObjectToJSON:(MenuItems *)mealObject
{
    NSMutableDictionary *mealJSONObject=[[NSMutableDictionary alloc] init];
    mealObject.comment=@"good";
    mealObject.nameAr=@"";
    mealObject.descriptionAr=@"";
    [mealJSONObject setObject:[NSNumber numberWithInt:[mealObject itemId]] forKey:@"menuItemsItemId"];
    [mealJSONObject setObject:[mealObject nameEn] forKey:@"menuItemsNameEn"];
    [mealJSONObject setObject:[NSNumber numberWithFloat:[mealObject price] ]forKey:@"menuItemsPrice"];
    [mealJSONObject setObject:[mealObject descriptionEn] forKey:@"menuItemsDescriptionEn"];
 //   [mealJSONObject setObject:[mealObject imageURL] forKey:@"menuItemsImageUrl"];
    [mealJSONObject setObject:[NSNumber numberWithInt:[mealObject quantity]] forKey:@"quantity"];
  //  [mealJSONObject setObject:[mealObject comment] forKey:@"comment"];
   // [mealJSONObject setObject:[NSNumber numberWithInt:[mealObject rating]]forKey:@"rating"];
    [mealJSONObject setObject:[mealObject descriptionAr] forKey:@"menuItemsDescriptionAr"];
    [mealJSONObject setObject:[mealObject nameAr] forKey:@"menuItemsNameAr"];
    [mealJSONObject setObject:[NSNumber numberWithFloat:[mealObject price]] forKey:@"price"];
    
    return mealJSONObject;

}
@end
