//
//  CookDTO.h
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Cook.h"
#import "Etbo5lyDatabaseManager.h"
#import "MenuItemDAO.h"
@interface CookDAO : NSObject
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchRequest *fetchRequest;
    MenuItemDAO *menuItemsRef;
    
}
@property NSMutableArray * cooksManagedObject;
@property NSMutableArray * selectedCooks;
-(id) initWithManagedObject;
-(void) getCooksManagedObject ;
-(NSMutableArray *)fetchAndGetAllCooks;
-(void) deleteAllCooks;
-(void) insertCooks:(NSArray *)cooksArray;
-(Cook *) selectCookBasedOnID : (int) CookID;
@end
