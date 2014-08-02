//
//  LocalMenuDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MenuModel;

@interface LocalMenuDataProvider : NSObject

// store data to local data base
+ (void) storeMenuData:(MenuModel*) mapModel;

// delete all rows from entity map
+ (void) resetMenuData;

// load data from local data base
+ (void) loadMenuDataWithBlock: (void (^)(MenuModel*, NSError*))callback;

// check is data in local data base
+ (BOOL) isData;

@end
