//
//  ParserToJSON.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



@interface ParserToJSON : NSObject

+(NSData*)createJSONDataWithObjects:(NSArray*)objects keys:(NSArray*)keys;

@end
