//
//  CookDTO.m
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "CookDAO.h"

@implementation CookDAO
-(id)initWithManagedObject
{
    self=[super init];
    managedObjectContext=[Etbo5lyDatabaseManager getManagedObjectContext];
    return  self;
}
-(void)getCooksManagedObject
{
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cook"];
    _cooksManagedObject = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}
-(void)deleteAllCooks
{
    if (_cooksManagedObject == nil) {
        // handle error
        //mt3mlsh haga lw l table fadi
    } else {
        for (NSManagedObject *object in _cooksManagedObject) {
            [managedObjectContext deleteObject:object];
        }
}}
-(NSMutableArray *)fetchAndGetAllCooks
{
    [self getCooksManagedObject];
    _selectedCooks=[NSMutableArray array];
    for (int i=0; i<_cooksManagedObject.count; i++) {
        NSManagedObject *managedObjectCook=[_cooksManagedObject objectAtIndex:i];
        Cook *fetchedCook=[[Cook alloc] initWithInfo];
        fetchedCook.name=[managedObjectCook valueForKey:@"name"];
        fetchedCook.userId=[[managedObjectCook valueForKey:@"id"] integerValue];
        fetchedCook.email=[managedObjectCook valueForKey:@"email"];
        fetchedCook.password=[managedObjectCook valueForKey:@"password"];
        fetchedCook.address=[managedObjectCook valueForKey:@"address"];
        fetchedCook.imageURL=[managedObjectCook valueForKey:@"imageURL"];
        fetchedCook.phone=[managedObjectCook valueForKey:@"phone"];
        fetchedCook.latitude=[[managedObjectCook valueForKey:@"latitude"] doubleValue];
        fetchedCook.longitude=[[managedObjectCook valueForKey:@"longitude"] doubleValue];
        fetchedCook.endWorkingHours=[managedObjectCook valueForKey:@"end_working_hours"];
        fetchedCook.startWorkingHours=[managedObjectCook valueForKey:@"start_working_hours"];
        fetchedCook.registerationDate=[managedObjectCook valueForKey:@"registeration_date"];

        [_selectedCooks addObject:fetchedCook];
    }
    return _selectedCooks;
}
-(void)insertCooks:(NSArray *)cooksArray
{
    [self deleteAllCooks];
    NSError *error = nil;
    for (int i=0; i<cooksArray.count; i++) {
        NSManagedObject *newCook=[NSEntityDescription insertNewObjectForEntityForName:@"Cook" inManagedObjectContext:managedObjectContext];
        [newCook setValue:[[cooksArray objectAtIndex:i] valueForKey:@"id"] forKey:@"id"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"address"] forKey:@"address"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"email"] forKey:@"email"];
        [newCook setValue:@"cook" forKey:@"type"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"latitude"] forKey:@"latitude"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"longitude"] forKey:@"longitude"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"password"] forKey:@"password"];
        [newCook setValue:[[cooksArray objectAtIndex:i] objectForKey:@"phone"] forKey:@"phone"];
        NSLog(@"hh %lld",[[[cooksArray objectAtIndex:i] objectForKey:@"registerationDate"] longLongValue]);
        
        NSLog(@"%@",[NSDate dateWithTimeIntervalSince1970:([[[cooksArray objectAtIndex:i ] objectForKey:@"registerationDate"] longLongValue]/1000.0)]);
        
        [newCook setValue:[NSDate dateWithTimeIntervalSince1970:([[[cooksArray objectAtIndex:i] objectForKey:@"registerationDate"] longLongValue]/1000)] forKey:@"registeration_date"];
        [newCook setValue:[NSDate dateWithTimeIntervalSince1970:([[[cooksArray objectAtIndex:i] objectForKey:@"endWorkingHours"] longLongValue]/1000)] forKey:@"end_working_hours"];
        [newCook setValue:[NSDate dateWithTimeIntervalSince1970:([[[cooksArray objectAtIndex:i] objectForKey:@"startWorkingHours"] longLongValue]/1000)] forKey:@"start_working_hours"];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[[cooksArray objectAtIndex:i] objectForKey:@"resourcesURL"],[[cooksArray objectAtIndex:i] objectForKey:@"imageURL"]]);
        [newCook setValue:[NSString stringWithFormat:@"%@%@",[[cooksArray objectAtIndex:i] objectForKey:@"resourcesURL"],[[cooksArray objectAtIndex:i] objectForKey:@"imageURL"]] forKey:@"imageURL"];
        
    }
//    if (![managedObjectContext inser:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
}
-(Cook *)selectCookBasedOnID:(int)CookID
{
    Cook *cookBasedOnId=[[Cook alloc] initWithInfo];
    NSFetchRequest *req=[[NSFetchRequest alloc] initWithEntityName:@"Cook"];
    req.predicate=[NSPredicate predicateWithFormat:@"id == %d",CookID];
    NSArray *cooksBasedOnId=[managedObjectContext executeFetchRequest:req error:nil];
    for (Cook * newCook in cooksBasedOnId) {
        cookBasedOnId=newCook;
    }
    return cookBasedOnId;
}
@end
