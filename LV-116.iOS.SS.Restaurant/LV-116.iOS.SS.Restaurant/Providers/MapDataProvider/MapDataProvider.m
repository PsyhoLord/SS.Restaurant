//
//  MapDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteMapDataProvider.h"
#import "LocalMapDataProvider.h"
#import "MapDataProvider.h"

#import "MapModel.h"
#import "TableModel.h"


@implementation MapDataProvider

// load map data from remote and create map model with these data
// calls block when model has created
+ (void)loadMapDataWithBlock:(void (^)(MapModel*, NSError*))callback
{
    
    if ( [LocalMapDataProvider isData] ) {
        [LocalMapDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
            
            callback(mapModel, error);
            
        }];
    } else {
        [RemoteMapDataProvider loadMapDataWithBlock: ^(MapModel *mapModel, NSError *error) {
            
            if ( error == nil ) {
                [LocalMapDataProvider storeMapData: mapModel];
            }
            
            callback(mapModel, error);
            
        } ];
    }
}

// load map background image from remote
// calls block when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    [RemoteMapDataProvider loadMapBackgroundImageWithBlock:^(UIImage *mapBackgroundImage, NSError *error) {
        
        callback(mapBackgroundImage, error);
        
    } ];
}




@end
