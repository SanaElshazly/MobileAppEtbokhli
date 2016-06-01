//
//  MenuItemDTO.m
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "MenuItemDAO.h"


@implementation MenuItemDAO


-(id)initWithManagedObject
{
    self=[super init];
    managedObjectContext=[Etbo5lyDatabaseManager getManagedObjectContext];
    return  self;
}
-(void)getMenuItemsManagedObject
{
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Menu_items"];
    _menuItemsManagedObject = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}
-(NSMutableArray *)fetchAndGetAllMenuItems
{
    [self getMenuItemsManagedObject];
    _selectedMenuItems=[NSMutableArray array];
    for (int i=0; i<_menuItemsManagedObject.count; i++) {
        NSManagedObject *managedObjectMenuItem = [_menuItemsManagedObject objectAtIndex:i];
        MenuItems *fetchedMenuItem = [[MenuItems alloc] initWithInfo];
        fetchedMenuItem.nameEn = [managedObjectMenuItem valueForKey:@"name_en"];
        fetchedMenuItem.itemId = [[managedObjectMenuItem valueForKey:@"item_id"] integerValue];
        fetchedMenuItem.price = [[managedObjectMenuItem valueForKey:@"price"] integerValue];
        fetchedMenuItem.itemRate = [[managedObjectMenuItem valueForKey:@"item_rate"] integerValue];
        fetchedMenuItem.imageURL = [managedObjectMenuItem valueForKey:@"image_URL"];
        fetchedMenuItem.descriptionEn = [managedObjectMenuItem valueForKey:@"description_en"];

        [_selectedMenuItems addObject:fetchedMenuItem];
    }
    return _selectedMenuItems;
}
-(void)insertMenuItems:(NSArray *)menuItemsArray
{
    NSError *error = nil;
    
    for (int i=0; i<menuItemsArray.count; i++) {
        NSManagedObject *newMenuItem=[NSEntityDescription insertNewObjectForEntityForName:@"Menu_items" inManagedObjectContext:managedObjectContext];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] valueForKey:@"name_en"] forKey:@"name_en"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"item_id"] forKey:@"item-id"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"item_rate"] forKey:@"item_rate"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"image_URL"] forKey:@"image_URL"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"description_en"] forKey:@"description_en"];
    }
    //    if (![managedObjectContext inser:&error]) {
    //        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    //    }
}


@end