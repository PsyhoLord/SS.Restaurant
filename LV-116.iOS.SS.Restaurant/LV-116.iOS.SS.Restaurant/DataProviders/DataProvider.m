//
//  DataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "DataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"
#import "MapModel.h"
#import "TableModel.h"

@implementation DataProvider
#warning Is there any reason that DataProvider contains internal state ? I'm taking about menuModel, mapModel, CurrentCategory.
#warning As for me the DataProvider should stateless and provide operations only. Get inout parameter and return response. That's it !

// load menu data from remote and create menu model with these data
// calls block when model has created
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
   
    [RemoteDataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {

        callback(menuModel, error);
        
    } ];
}

// load map data from remote and create map model with these data
// calls block when model has created
+ (void)loadMapDataWithBlock:(void (^)(MapModel*, NSError*))callback
{
    [RemoteDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        
        callback(mapModel, error);
        
    } ];
}

// load menu item image from remote
// calls block when image is
+ (void)loadMenuItemImage:(MenuItemModel*)menuItemModel withBlock:(void (^)(UIImage*, NSError*))callback
{
    [RemoteDataProvider loadMenuItemImageById:menuItemModel.Id withBlock:^(UIImage *menuItemImage, NSError *error) {
        
        callback(menuItemImage, error);
        
    } ];
}

// load map background image from remote
// calls block when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    [RemoteDataProvider loadMapBackgroundImageWithBlock:^(UIImage *mapBackgroundImage, NSError *error) {
        
        callback(mapBackgroundImage, error);
        
    } ];
}

@end
