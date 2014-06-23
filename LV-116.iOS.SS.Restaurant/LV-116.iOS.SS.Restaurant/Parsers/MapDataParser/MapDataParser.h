//
//  MapDataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola on 6/23/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  MapModel;

@interface MapDataParser : NSObject

+(MapModel*) parseEntireMap:(NSData*) data;


@end
