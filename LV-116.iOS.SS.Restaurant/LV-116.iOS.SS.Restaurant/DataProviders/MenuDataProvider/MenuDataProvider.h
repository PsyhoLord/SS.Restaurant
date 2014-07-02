//
//  MenuDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



@class MenuModel;
@class MapModel;
@class MenuItemModel;

@interface MenuDataProvider : NSObject

// load menu data from remote and create menu model with these data
// calls block when model has created
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback;

// load menu item image from remote
// calls block when image is
+ (void)loadMenuItemImage:(MenuItemModel*)menuItemModel withBlock:(void (^)(UIImage*, NSError*))callback;

@end
