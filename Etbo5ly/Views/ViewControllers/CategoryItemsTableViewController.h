//
//  CategoryItemsTableViewController.h
//  Etbo5ly
//
//  Created by Sana Elshazly on 6/11/16.
//  Copyright © 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cook.h"
#import "CookServices.h"
#import "CategoryDTO.h"
#import "CategoryItemsTableViewController.h"
#import "UIImageView+WebCache.h"

@interface CategoryItemsTableViewController : UITableViewController
{
    CookServices *cooksRequestedCategories;

}


@property int cookID;
@property int categoryID;
//@property (strong,nonatomic) CategoryDTO *categoryItems;
@property (strong,nonatomic) NSMutableArray * cookCategoryItems;

@property (strong, nonatomic) IBOutlet UITableView *categoryItemsTable;


@end
