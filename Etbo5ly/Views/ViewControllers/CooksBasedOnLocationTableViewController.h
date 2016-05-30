//
//  CooksBasedOnLocationTableViewController.h
//  Etbo5ly
//
//  Created by ITI on 5/27/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h" 
@interface CooksBasedOnLocationTableViewController : UITableViewController
-(id) initWithCooksArray : (NSArray *) cooksBasdedOnLocation;
@property (strong,nonatomic) NSArray * cooksOnLocation;
@end
