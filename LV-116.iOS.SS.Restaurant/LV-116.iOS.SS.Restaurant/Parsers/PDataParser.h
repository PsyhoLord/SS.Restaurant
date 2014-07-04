//
//  DataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@protocol PDataParser <NSObject>

// parse all menu tree
// (NSData*) data - data to parse
+ (id)parse:(NSData*) data parsingError:(NSError**)parseError;

@end
