//
//  MenuRemoteDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ServiceAgent.h"

// class RemoteDataProvider is needed for get data from server
// and interpret returned data
@class MenuModel;
@class MapModel;

@interface RemoteDataProvider : NSObject

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback;

// get map data from remote server with help of ServiceAgent
// (void (^)(MapModel*, NSError*)) callback - block which will call when data is
+ (void) loadMapDataWithBlock:(void (^)(MapModel*, NSError*)) callback;

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback;

// download image for MapModel
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback;




//// get menu data from server
//// (int)Id - id of category which we need to get data from it
//// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
//-(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback;



@end
