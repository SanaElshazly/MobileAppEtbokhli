//
//  Etbo5lyDatabaseManager.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "Etbo5lyDatabaseManager.h"

@implementation Etbo5lyDatabaseManager
+ (NSManagedObjectContext *)getManagedObjectContext {
    context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    return context;
}
@end
