//
//  orderHistoryTableViewController.h
//  Etbo5ly
//
//  Created by MDW Event on 6/12/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "UserServices.h"
#import "Etbo5lyNetworkDelegate.h"
#import "CookDAO.h"
#import "UIImageView+WebCache.h"
#import "BasketTableViewController.h"
@interface orderHistoryTableViewController : UITableViewController <Etbo5lyNetworkDelegate>
{
    User *registeredUser;
    UserDAO *userDBFunctions;
    CookDAO *cookDBFunctions;
    Cook *orderCook;

}
@property NSMutableArray * allUserOrders;
@end
