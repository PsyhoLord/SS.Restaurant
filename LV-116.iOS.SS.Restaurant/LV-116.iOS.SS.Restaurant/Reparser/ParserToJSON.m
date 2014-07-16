//
//  ParserToJSON.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ParserToJSON.h"

@implementation ParserToJSON

// Return JSON data which are based on arays.
+(NSData*)createJSONDataWithObjects:(NSArray*)objects keys:(NSArray*)keys
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects: objects
                                                                     forKeys: keys];
    NSError *error = nil;
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject: dict
                                                        options: NSJSONWritingPrettyPrinted
                                                          error: &error];
    if( error != nil ) {
        return nil;
    } else {
        return JSONData;
    }
}

@end
