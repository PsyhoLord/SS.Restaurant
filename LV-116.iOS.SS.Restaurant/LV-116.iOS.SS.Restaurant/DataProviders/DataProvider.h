//
//  DataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"
#import "RemoteDataProvider.h"

extern NSString *const notificationNameMenuTreeIsFinished;
extern NSString *const notificationItemImageDownloadIsFinished;
extern NSString *const menuItemKey;
extern NSString *const menuCellIndexKey;


@class MapModel;
// DataProvider class makes decision where it has to get data

@interface DataProvider : NSObject

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data if it hasn't data
// if it has data than it asks _menuModel to get menu data
// when menu tree will be finished it send notification notificationNameMenuTreeIsFinished
// (MenuCategory*)category - pointer to an category we want to get in
-(MenuCategoryModel*) getMenuData:(MenuCategoryModel*)category;

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data any time we want to get menu data
// (MenuCategory*)category - pointer to an category we want to get in
// FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback - block will called asynchronous when it is menu data of current category
-(MenuCategoryModel*) getMenuData:(MenuCategoryModel*)category FromNetWithResponseBlock:(void (^)(MenuCategoryModel*, NSError*))callback;

-(MapModel*)getMapData;

@end
