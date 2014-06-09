//
//  DataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataParser <NSObject>

+(NSMutableArray*) parse:(NSData*) data;

@end
