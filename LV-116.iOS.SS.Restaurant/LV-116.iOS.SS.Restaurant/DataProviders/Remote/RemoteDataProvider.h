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

@interface RemoteDataProvider : NSObject

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
-(void)getEntireMenuDataWithResponseBlock:(void (^)(MenuModel*, NSError*))callback;

// get menu data from server
// (int)Id - id of category which we need to get data from it
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
-(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback;

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
-(void)downloadImageForItemId:(int)itemId withBlock:(void (^)(UIImage*, NSError*))callback;

@end
