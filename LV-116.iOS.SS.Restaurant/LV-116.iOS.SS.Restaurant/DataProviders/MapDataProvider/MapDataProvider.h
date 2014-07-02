//
//  MapDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//


@class MenuModel;
@class MapModel;
@class MenuItemModel;

@interface MapDataProvider : NSObject

// load map data from remote and create map model with these data
// calls block when model has created
+ (void)loadMapDataWithBlock:(void (^)(MapModel*, NSError*))callback;


// load map background image from remote
// calls block when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback;


@end
