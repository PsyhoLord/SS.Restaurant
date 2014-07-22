//
//  OrdersDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersDataParser.h"
#import "OrderModel.h"

static NSString *const kOrderKeyId        = @"Id";
static NSString *const kOrderKeyClosed    = @"Closed";
static NSString *const kOrderKeyTableId   = @"TableId";
static NSString *const kOrderKeyTimeStamp = @"Timestamp";
static NSString *const kOrderKeyUserId    = @"UserId";



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

+ (OrderModel*)createOrderModel:(NSMutableDictionary *)orderDictionary
{
    OrderModel *orderModel;
    orderModel = [[OrderModel alloc] initWithId: [[orderDictionary valueForKey: kOrderKeyId] intValue]
                                       isClosed: [[orderDictionary valueForKey: kOrderKeyClosed] boolValue]
                                        tableId: [[orderDictionary valueForKey: kOrderKeyTableId] intValue]
                                      timestamp: [orderDictionary valueForKey:  kOrderKeyTimeStamp]
                                         userId: [[orderDictionary valueForKey: kOrderKeyUserId] intValue]
                  ];
    return orderModel;
}

+ (NSArray*)parseDictionary:(NSMutableDictionary*)arrayOfOrdersDictionary
{
    NSMutableArray *arrayOfTableOrders = [[NSMutableArray alloc] init];
    OrderModel *orderModel;
    
    if([arrayOfOrdersDictionary isKindOfClass:[NSMutableArray class]]){
        for ( NSMutableDictionary *orderDictionary in arrayOfOrdersDictionary ) {
            orderModel = [self createOrderModel:orderDictionary];
            [arrayOfTableOrders addObject: orderModel];
        }
        
    } else if ( [arrayOfOrdersDictionary isKindOfClass:[NSMutableDictionary class]] ) {
        orderModel = [self createOrderModel:arrayOfOrdersDictionary];
        [arrayOfTableOrders addObject: orderModel];
    }
    
    return arrayOfTableOrders;
}



@end
