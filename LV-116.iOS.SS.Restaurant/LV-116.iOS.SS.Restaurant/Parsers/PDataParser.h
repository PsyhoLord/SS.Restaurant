//
//  DataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

@protocol PDataParser <NSObject>

// parse all menu tree
// (NSData*) data - data to parse
+(MenuModel*) parseEntireMenu:(NSData*) data;

// parse data for current category
// (NSData*) data - data to parse
+(NSMutableArray*) parseCurrentCategory:(NSData*) data;

@end
