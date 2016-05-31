//
//  Etbo5lyDatabaseManager.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
static NSManagedObjectContext *context;
@interface Etbo5lyDatabaseManager : NSObject

+ (NSManagedObjectContext *)getManagedObjectContext;
@end
