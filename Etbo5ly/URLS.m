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
    return @"url";
}

+(NSString *)registeration{
    return @"url";
}

+(NSString *)profile{
    return @"url";
}

+(NSString *) allMeals : (int) pagenum{
    
    //Etbo5ly-Web/rest/meal/page?page=1
    
    urlPath = [NSString stringWithFormat:@" %s %d", "http://www.mobiledeveloperweekend.net/service/getSessions?page=", pagenum ];
    return urlPath;
}

+(NSString *) allCooks : (int) pagenum{
    
    //Etbo5ly-Web/rest/cook/page?page=1
    
    urlPath = [NSString stringWithFormat:@" %s %d", "http://www.mobiledeveloperweekend.net/service/getSessions?page=", pagenum ];
    return urlPath;
}

+(NSString *)locationBasedCooks : (long) longitude : (long) latitude {
    
    //Etbo5ly-Web/rest/cook/nearbyCooks2?long=30.975534&latit=30.059376
    
    urlPath = [NSString stringWithFormat:@" %s %ld %ld", "http://www.mobiledeveloperweekend.net/service/getSessions?page=", longitude, latitude ];
    return urlPath;
    return @"http://www.mobiledeveloperweekend.net/service/attendAttendee?";
}

+(NSString *)regionBasedCooks : (int) regionID {
    
    //Etbo5ly-Web/rest/cook/byRegion?region=7
    
    urlPath = [NSString stringWithFormat:@" %s %d", "http://www.mobiledeveloperweekend.net/service/getSessions?region=", regionID ];
    return urlPath;
    return @"http://www.mobiledeveloperweekend.net/service/attendAttendee?";
}

+(NSString *)countriesWithRegions{
    
    //Etbo5ly-Web/rest/region/countries
    
    return @"http://www.mobiledeveloperweekend.net/service/getAttendeeAgenda?";
}


@end
