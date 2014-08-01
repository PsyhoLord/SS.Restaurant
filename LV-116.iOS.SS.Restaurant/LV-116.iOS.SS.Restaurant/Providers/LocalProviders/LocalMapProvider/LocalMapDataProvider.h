//
//  LocalMapDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 8/1/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MapModel;

@interface LocalMapDataProvider : NSObject

// store data to local data base
+ (void) storeMapData:(MapModel*) mapModel;

// delete all rows from entity map
+ (void) resetMapData;

// load data from local data base
+ (void) loadMapDataWithBlock: (void (^)(MapModel*, NSError*))callback;

// check is data in local data base
+ (BOOL) isData;

@end
