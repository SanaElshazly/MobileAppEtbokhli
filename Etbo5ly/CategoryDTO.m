//
//  CategoryDTO.m
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "CategoryDTO.h"

@implementation CategoryDTO
-(id)initWithInfo
{
    self = [super init];
    return self;

}
-(id) initWithInfo:(int)categoryId setCategoryName:(NSString *)nameEn
{
    self = [super init];
    _categoryId=categoryId;
    _nameEn=nameEn;
    return self;
}
@end
