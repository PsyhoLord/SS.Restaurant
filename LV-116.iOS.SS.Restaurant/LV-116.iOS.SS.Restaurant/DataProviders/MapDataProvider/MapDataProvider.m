//
//  MapDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteDataProvider.h"
#import "MapDataProvider.h"
#import "MapModel.h"
#import "TableModel.h"


@implementation MapDataProvider

// load map data from remote and create map model with these data
// calls block when model has created
+ (void)loadMapDataWithBlock:(void (^)(MapModel*, NSError*))callback
{
    [RemoteDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        
        callback(mapModel, error);
        
    } ];
}


// load map background image from remote
// calls block when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    [RemoteDataProvider loadMapBackgroundImageWithBlock:^(UIImage *mapBackgroundImage, NSError *error) {
        
        callback(mapBackgroundImage, error);
        
    } ];
}

@end
