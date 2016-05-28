//
//  CategoryDTO.h
//  Etbo5ly
//
//  Created by MDW Event on 5/21/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryDTO : NSObject
{
    int iddd;
}
    @property int categoryId;
    @property NSString * nameEn;

-(id) initWithInfo;
-(id) initWithInfo : (int) categoryId setCategoryName :(NSString*) nameEn;
@end
