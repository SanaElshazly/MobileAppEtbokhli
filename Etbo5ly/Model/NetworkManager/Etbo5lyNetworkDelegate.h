//
//  Etbo5lyNetworkDelegate.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Etbo5lyNetworkDelegate <NSObject>

-(void) handle:(id) dataRetreived :(NSString*) serviceName;
-(void) handleWithFailure:(NSError*) error ;//:(NSString*) serviceName;


@end
