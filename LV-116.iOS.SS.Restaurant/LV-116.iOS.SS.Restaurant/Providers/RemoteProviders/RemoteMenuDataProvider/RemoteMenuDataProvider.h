//
//  RemoteMenuDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MenuModel;

@interface RemoteMenuDataProvider : NSObject

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback;

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback;

@end
