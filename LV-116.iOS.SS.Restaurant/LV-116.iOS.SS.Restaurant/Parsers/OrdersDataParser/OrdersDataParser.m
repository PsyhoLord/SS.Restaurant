//
//  OrdersDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersDataParser.h"
#import "OrderModel.h"

@implementation OrdersDataParser

+ (id)parse:(NSData*) data parsingError:(NSError**) parseError
{
    NSError *parsingError;
    
    // Calling a method, which will be convert data from JSON to OrderModel.
    NSMutableDictionary *responseForTableOrders = [NSJSONSerialization JSONObjectWithData: data
                                                                                  options: NSJSONReadingMutableContainers
                                                                                    error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    
    return [self parseDictionary:responseForTableOrders];
}

+ (NSMutableArray*)parseDictionary:(NSMutableDictionary*)arrayOfOrdersDictionary
{
    NSMutableArray *arrayOfTableOrders = [[NSMutableArray alloc] init];

    for ( NSMutableDictionary *orderDictionary in arrayOfOrdersDictionary ) {
        OrderModel *orderModel = [[OrderModel alloc] initWithId: [[orderDictionary valueForKey:@"Id"] intValue]
                                                       isClosed: [[orderDictionary valueForKey:@"closed"] boolValue]
                                                        tableId: [[orderDictionary valueForKey:@"tableId"] intValue]
                                                      timestamp: [[orderDictionary valueForKey:@"timestamp"] dateFormat]
                                                         userId: [[orderDictionary valueForKey:@"userId"] intValue]
                         ];
        
        [arrayOfTableOrders addObject: orderModel];
    }
    return arrayOfTableOrders;
    
}

@end
