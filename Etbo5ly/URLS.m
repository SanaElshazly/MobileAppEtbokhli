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
    return @"http://www.mobiledeveloperweekend.net/service/login?";
}
+(NSString *) allMeals : (int) pagenum{
    urlPath = [NSString stringWithFormat:@" %s %d", "http://www.mobiledeveloperweekend.net/service/getSessions?page=", pagenum ];
    return urlPath;
}
+(NSString *)allCooks{
    return @"http://www.mobiledeveloperweekend.net/service/getSpeakers?";
}
+(NSString *)profile{
    return @"http://www.mobiledeveloperweekend.net/service/getAttendeeProfile?";
}
+(NSString *)registeration{
    return @"http://www.mobiledeveloperweekend.net/service/profileImage?";
}
+(NSString *)locationBasedCooks{
    return @"http://www.mobiledeveloperweekend.net/service/attendAttendee?";
}
+(NSString *)regionBasedCooks{
    return @"http://www.mobiledeveloperweekend.net/service/getAttendeeAgenda?";
}


@end
