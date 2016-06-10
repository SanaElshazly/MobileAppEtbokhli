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
-(void)deleteAllMeals
{
    if (_menuItemsManagedObject == nil) {
        // handle error
        //mt3mlsh haga lw l table fadi
    } else {
        for (NSManagedObject *object in _menuItemsManagedObject) {
            [managedObjectContext deleteObject:object];
        }
}}
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
        fetchedMenuItem.cookName= [managedObjectMenuItem valueForKey:@"cookName"];
        [_selectedMenuItems addObject:fetchedMenuItem];
    }
    return _selectedMenuItems;
}
-(void)insertMenuItems:(NSArray *)menuItemsArray
{
    NSError *error = nil;
    [self deleteAllMeals];
    for (int i=0; i<menuItemsArray.count; i++) {
        NSManagedObject *newMenuItem=[NSEntityDescription insertNewObjectForEntityForName:@"Menu_items" inManagedObjectContext:managedObjectContext];
        Cook *mealCook=[[Cook alloc] initWithInfo];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] valueForKey:@"nameEn"] forKey:@"name_en"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"itemId"] forKey:@"item_id"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"itemRate"] forKey:@"item_rate"];
        [newMenuItem setValue:[NSString stringWithFormat:@"%@%@",[[menuItemsArray objectAtIndex:i] objectForKey:@"resourcesURL"],[[menuItemsArray objectAtIndex:i] objectForKey:@"imageUrl"]] forKey:@"image_URL"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"descriptionEn"] forKey:@"description_en"];
        //[newMenuItem setValue:[] forKey:@"cook_id"];
        [newMenuItem setValue:[[menuItemsArray objectAtIndex:i] objectForKey:@"cookName"] forKey:@"cookName"];
      //  [newMenuItem setValue:"cook_id" forKey:];
    }
    //    if (![managedObjectContext inser:&error]) {
    //        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    //    }
}


@end