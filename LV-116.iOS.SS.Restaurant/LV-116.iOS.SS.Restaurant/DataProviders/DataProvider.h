//
//  DataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//


#import "RemoteDataProvider.h"

@class MenuModel;
@class MapModel;
@class MenuItemModel;

// DataProvider class makes decision where it has to get data

@interface DataProvider : NSObject

// load menu data from remote and create menu model with these data
// calls block when model has created
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback;

// load map data from remote and create map model with these data
// calls block when model has created
+ (void)loadMapDataWithBlock:(void (^)(MapModel*, NSError*))callback;

// load menu item image from remote
// calls block when image is
+ (void)loadMenuItemImage:(MenuItemModel*)menuItemModel withBlock:(void (^)(UIImage*, NSError*))callback;

// load map background image from remote
// calls block when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback;


@end
