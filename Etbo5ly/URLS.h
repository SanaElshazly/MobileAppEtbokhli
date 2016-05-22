//
//  URLS.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *urlPath;

@interface URLS : NSObject

+(NSString *)login;
+(NSString *)allMeals : (int) pagenum;
+(NSString *)allCooks;
+(NSString *)profile;
+(NSString *)registeration;
+(NSString *)regionBasedCooks;
+(NSString *)locationBasedCooks;

@end
