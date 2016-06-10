//
//  URLS.m
//  Etbo5ly
//
//  Created by Sana Elshazly on 5/22/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import "URLS.h"

@implementation URLS

+(NSString *)login{
    urlPath=[NSString stringWithFormat:@"%@%@", IP_ADDRESS , @"user/login" ];

    return urlPath;
}

+(NSString *)registeration{
    return @"url";
}

+(NSString *)profile{
    return @"url";
}

+(NSString *) allMeals : (int) pagenum{
    
    //Etbo5ly-Web/rest/meal/page?page=1
    
    urlPath = [NSString stringWithFormat:@"%@%@%d", IP_ADDRESS , @"page?page=", pagenum ];
    return urlPath;
}

+(NSString *) allCooks : (int) pagenum{
    
    urlPath = [NSString stringWithFormat:@"%@%@%d", IP_ADDRESS, @"cook/page?page=", pagenum ];
    return urlPath;
}

+(NSString *)locationBasedCooks : (double) longitude : (double) latitude {
    
    //Etbo5ly-Web/rest/cook/nearbyCooks2?long=30.975534&latit=30.059376
    
    urlPath = [NSString stringWithFormat:@"%@%@", IP_ADDRESS ,[NSString stringWithFormat:@"cook/nearbyCooks2?long=%f&&latit=%f" ,longitude,latitude]];
    return urlPath;
}

+(NSString *)regionBasedCooks : (int) regionID {
    
    //Etbo5ly-Web/rest/cook/byRegion?region=7
    
    urlPath = [NSString stringWithFormat:@"%@%@%d", IP_ADDRESS , @"cook/byRegion?region=", regionID ];
    return urlPath;
}

+(NSString *) cooksCategories:(int)cookID
{
    //Etbo5ly-Web/rest/cookCategories?cookId=2
    
    urlPath = [NSString stringWithFormat:@"%@%@%d", IP_ADDRESS , @"cookCategories?cookId=", cookID ];
    return urlPath;
}

+(NSString *)countriesWithRegions{
    
    //Etbo5ly-Web/rest/region/countries
    
    urlPath = [NSString stringWithFormat:@"%@%@", IP_ADDRESS , @"region/countries" ];
    return urlPath;
}
+(NSString *)createOrder
{
    urlPath = [NSString stringWithFormat:@"%@%@", IP_ADDRESS , @"createOrder" ];
    return urlPath;
}
+(NSString *)signUp
{
    urlPath = [NSString stringWithFormat:@"%@%@", IP_ADDRESS , @"customer/signUp" ];
    return urlPath;
}
@end
