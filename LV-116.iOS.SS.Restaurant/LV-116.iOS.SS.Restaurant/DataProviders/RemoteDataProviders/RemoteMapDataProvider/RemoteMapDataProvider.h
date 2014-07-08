//
//  RemoteMapDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MapModel;

@interface RemoteMapDataProvider : NSObject

// get map data from remote server with help of ServiceAgent
// (void (^)(MapModel*, NSError*)) callback - block which will call when data is
+ (void) loadMapDataWithBlock:(void (^)(MapModel*, NSError*)) callback;


// download image for MapModel
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback;

@end
