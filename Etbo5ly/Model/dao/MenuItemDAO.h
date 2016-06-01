//
//  MenuItemDTO.h
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Etbo5lyDatabaseManager.h"
#import "MenuItems.h"

@interface MenuItemDAO : NSObject
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchRequest *fetchRequest;
}

@property NSMutableArray * menuItemsManagedObject;
@property NSMutableArray * selectedMenuItems;
-(id) initWithManagedObject;
-(void) getMenuItemsManagedObject ;
-(NSMutableArray *)fetchAndGetAllMenuItems;
-(void) insertMenuItems:(NSArray *)menuItemsArray;
-(void)deleteAllMeals;

@end
