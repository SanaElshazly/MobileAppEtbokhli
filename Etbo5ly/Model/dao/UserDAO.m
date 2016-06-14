//
//  UserDTO.m
//  Etbo5ly
//
//  Created by MDW Event on 5/31/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "UserDAO.h"

@implementation UserDAO
-(id)initWithManagedObject
{
    self=[super init];
    managedObjectContext=[Etbo5lyDatabaseManager getManagedObjectContext];
    return  self;
}
-(BOOL)deleteUser
{
    NSError* error=nil;
    fetchRequest= [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"type == %@",@"user"]];
    NSArray* deleteArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (deleteArray != nil)
    {
        for (NSManagedObject* object in deleteArray)
        {
            [managedObjectContext deleteObject:object];
        }
        [managedObjectContext save:&error];
        return YES;
    }
    else
    {
        return NO;
    }
}
//-(User *)fetchAndGetUser
//{
//    [self getUserManagedObject];
//    
//    NSManagedObject *managedObjectCook=[_userManagedObject objectAtIndex:0];
//    User *fetchedUser=[[User alloc] initWithInfo];
//    fetchedUser.name=[managedObjectCook valueForKey:@"name"];
//    fetchedUser.userId=[[managedObjectCook valueForKey:@"id"] integerValue];
//    fetchedUser.email=[managedObjectCook valueForKey:@"email"];
//    fetchedUser.password=[managedObjectCook valueForKey:@"password"];
//    fetchedUser.address=[managedObjectCook valueForKey:@"address"];
//    fetchedUser.imageURL=[managedObjectCook valueForKey:@"imageURL"];
//    fetchedUser.phone=[managedObjectCook valueForKey:@"phone"];
//    fetchedUser.latitude=[[managedObjectCook valueForKey:@"latitude"] doubleValue];
//    fetchedUser.longitude=[[managedObjectCook valueForKey:@"longitude"] doubleValue];
//    fetchedUser.registerationDate=[managedObjectCook valueForKey:@"registeration_date"];
//    return fetchedUser;
//}

-(User *)selectRegisteredUser
{
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:@"type == %@",@"user"];
    User *fetchedUser=[[User alloc] initWithInfo];
    NSArray *users=[managedObjectContext executeFetchRequest:fetchRequest error:nil];
    if(users.count!=0)
    {
    NSManagedObject *managedObjectCook=[users objectAtIndex:0];
    
    fetchedUser.name=[managedObjectCook valueForKey:@"name"];
    fetchedUser.userId=[[managedObjectCook valueForKey:@"id"] integerValue];
    fetchedUser.email=[managedObjectCook valueForKey:@"email"];
    fetchedUser.password=[managedObjectCook valueForKey:@"password"];
    fetchedUser.address=[managedObjectCook valueForKey:@"address"];
    fetchedUser.imageURL=[managedObjectCook valueForKey:@"imageURL"];
    fetchedUser.phone=[managedObjectCook valueForKey:@"phone"];
    fetchedUser.latitude=[[managedObjectCook valueForKey:@"latitude"] doubleValue];
    fetchedUser.longitude=[[managedObjectCook valueForKey:@"longitude"] doubleValue];
    fetchedUser.registerationDate=[managedObjectCook valueForKey:@"registeration_date"];
    }
    return fetchedUser;
}

-(void)insertUser:(User *)userData
{
    
    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    [newUser setValue: [userData valueForKey:@"userId"] forKey:@"id"];
    [newUser setValue:[userData valueForKey:@"address"] forKey:@"address"];
    [newUser setValue:[userData valueForKey:@"email"] forKey:@"email"];
    [newUser setValue:@"user" forKey:@"type"];
  //  [newUser setValue:[userData valueForKey:@"latitude"] forKey:@"latitude"];
 //   [newUser setValue:[userData valueForKey:@"longitude"] forKey:@"longitude"];
    [newUser setValue:[userData valueForKey:@"name"] forKey:@"name"];
    [newUser setValue:[userData valueForKey:@"password"] forKey:@"password"];
    [newUser setValue:[userData valueForKey:@"phone"] forKey:@"phone"];
   // NSLog(@"hh %lld",[[userData valueForKey:@"registerationDate"] longLongValue]);
    
   // NSLog(@"%@",[NSDate dateWithTimeIntervalSince1970:([[userData valueForKey:@"registerationDate"] longLongValue]/1000.0)]);
    
   // [newUser setValue:[NSDate dateWithTimeIntervalSince1970:([[ userData valueForKey:@"registerationDate"] longLongValue]/1000)] forKey:@"registeration_date"];
   
  //  [newUser setValue:[NSString stringWithFormat:@"%@%@",[userData valueForKey:@"resourcesURL"],[userData valueForKey:@"imageURL"]] forKey:@"imageURL"];
}

@end
