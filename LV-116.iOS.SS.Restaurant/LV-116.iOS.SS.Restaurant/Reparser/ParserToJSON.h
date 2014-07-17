//
//  ParserToJSON.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



@interface ParserToJSON : NSObject

// Returns JSON data using arrays.
+(NSData*)createJSONDataWithObjects:(NSArray*)objects keys:(NSArray*)keys;

// Returns JSON data using dictionary.
+(NSData*)createJSONDataWithDictionary:(NSDictionary*)jsonDictionary;

// Return dictionary. We can use it for create JSON data.
+(NSDictionary*)createJSONStringsWithObjects:(NSArray*)objects keys:(NSArray*)keys;

@end
