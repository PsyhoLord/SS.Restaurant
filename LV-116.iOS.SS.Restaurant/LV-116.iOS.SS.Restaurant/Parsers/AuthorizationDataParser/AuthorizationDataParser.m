//
//  AuthorizationDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "AuthorizationDataParser.h"


@implementation AuthorizationDataParser

+ (id)parse:(NSData*) data parsingError:(NSError**) parseError
{
    NSError *parsingError;
    
    // Calling a method, which will be convert data from JSON to OrderModel.
    NSMutableDictionary *authorizationResponse = [NSJSONSerialization JSONObjectWithData: data
                                                                                 options: NSJSONReadingMutableContainers
                                                                                   error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    
    return authorizationResponse;
}

+ (NSMutableArray*)parseDictionary:(NSMutableDictionary*)arrayOfOrdersDictionary
{
    NSMutableArray *arrayOfTableOrders = [[NSMutableArray alloc] init];

    return arrayOfTableOrders;
    
}


@end
