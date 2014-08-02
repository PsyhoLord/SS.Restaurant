//
//  MenuDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteMenuDataProvider.h"
#import "MenuDataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

#import "LocalDataValidator.h"
#import "LocalMenuDataProvider.h"

@implementation MenuDataProvider

// load menu data from remote and create menu model with these data
// calls block when model has created
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
    if ( [LocalDataValidator isNeedForUpdateData] == NO && [LocalMenuDataProvider isData] ) {
        [LocalMenuDataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {
            
            callback(menuModel, error);
            
        }];
    } else {
        [RemoteMenuDataProvider loadMenuDataWithBlock: ^(MenuModel *menuModel, NSError *error) {
            
            if ( error == nil ) {
                [LocalMenuDataProvider resetMenuData];
                [LocalMenuDataProvider storeMenuData: menuModel];
            }
            
            callback(menuModel, error);
            
        } ];
    }
}

// load menu item image from remote
// calls block when image is
+ (void)loadMenuItemImage:(MenuItemModel*)menuItemModel withBlock:(void (^)(UIImage*, NSError*))callback
{
    [RemoteMenuDataProvider loadMenuItemImageById:menuItemModel.Id withBlock:^(UIImage *menuItemImage, NSError *error) {
        
        callback(menuItemImage, error);
        
    } ];
}

@end
