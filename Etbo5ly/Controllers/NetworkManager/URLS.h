//
//  URLS.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *urlPath;
static  NSString *IP_ADDRESS = @"http://10.118.48.212:8084/Etbo5ly-Web/rest/";

@interface URLS : NSObject

+(NSString *)login;
+(NSString *)registeration;
+(NSString *)profile;
+(NSString *)allMeals : (int) pagenum;
+(NSString *)allCooks : (int) pagenum;
+(NSString *)regionBasedCooks : (int) regionID;
+(NSString *)locationBasedCooks : (double) longitude : (double) latitude;
+(NSString *) cooksCategories : (int) cookID;
+(NSString *) cooksCategoryMeals: (int) cookID : (int) categoryID;
+(NSString *) getAllOrderHistory : (int) userId;
+(NSString *)countriesWithRegions;
+(NSString *) createOrder ;
+(NSString *) signUp;
+(NSString *) getNonRatingOrder : (int) userID;
+(NSString *) rateOrder;
@end
