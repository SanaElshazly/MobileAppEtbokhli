//
//  ordersRatingTableViewController.h
//  Etbo5ly
//
//  Created by ITI on 6/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "UserServices.h"
#import "Etbo5lyNetworkDelegate.h"
@interface ordersRatingTableViewController : UITableViewController <Etbo5lyNetworkDelegate>
{
    UserServices *userRequestedServices;
}
@property NSMutableArray *allNonRatedOrder;

- (IBAction)changeRatingValue:(id)sender;

@end
