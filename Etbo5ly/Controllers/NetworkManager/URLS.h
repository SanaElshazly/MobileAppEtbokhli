//
//  URLS.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *urlPath;
static  NSString *IP_ADDRESS = @"http://192.168.1.106:8084/Etbo5ly-Web/rest/";

@interface URLS : NSObject

+(NSString *)login;
+(NSString *)registeration;
+(NSString *)profile;
+(NSString *)allMeals : (int) pagenum;
+(NSString *)allCooks : (int) pagenum;
+(NSString *)regionBasedCooks : (int) regionID;
+(NSString *)locationBasedCooks : (double) longitude : (double) latitude;
+(NSString *)countriesWithRegions;
+(NSString *) createOrder ;
+(NSString *) signUp;
@end
