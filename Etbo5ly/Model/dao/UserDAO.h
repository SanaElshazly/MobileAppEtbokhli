//
//  UserDTO.h
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Etbo5lyDatabaseManager.h"
#import "User.h"
@interface UserDAO : NSObject
{

    NSManagedObjectContext *managedObjectContext;
    NSFetchRequest *fetchRequest;
}
@property NSMutableArray * userManagedObject;
@property NSMutableArray * selectedUser;
-(id) initWithManagedObject;
-(void) getUserManagedObject ;
-(User *)fetchAndGetUser;
-(void) deleteUser;
-(void) insertUser:(User *)userData;
-(User *) selectCookBasedOnID : (int) CookID;
-(User *)selectRegisteredUser;
@end