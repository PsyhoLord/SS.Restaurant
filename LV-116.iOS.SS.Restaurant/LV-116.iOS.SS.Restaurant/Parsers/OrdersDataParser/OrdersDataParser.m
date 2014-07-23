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
    NSMutableDictionary *ordersResponse = [NSJSONSerialization JSONObjectWithData: data
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    
    return [self parseDictionary:ordersResponse];
}

+ (NSArray*)parseDictionary:(NSMutableDictionary*)ordersDictionary
{
    NSMutableArray *orders = [[NSMutableArray alloc] init];
    OrderModel *order;
    
    if([ordersDictionary isKindOfClass:[NSMutableArray class]]){
        for ( NSMutableDictionary *orderDictionary in ordersDictionary ) {
            
            order = [self createOrderModel:orderDictionary];
            [orders addObject: order];
            
        }
    } else if ( [ordersDictionary isKindOfClass:[NSMutableDictionary class]] ) {
        
        order = [self createOrderModel:ordersDictionary];
        [orders addObject: order];
        
    }
    
    return orders;
}

+ (OrderModel*)createOrderModel:(NSMutableDictionary *)orderDictionary
{
    OrderModel *order;
    order = [[OrderModel alloc] initWithId: [[orderDictionary valueForKey: kOrderKeyId] intValue]
                                  isClosed: [[orderDictionary valueForKey: kOrderKeyClosed] boolValue]
                                   tableId: [[orderDictionary valueForKey: kOrderKeyTableId] intValue]
                                 timestamp: [orderDictionary valueForKey:  kOrderKeyTimeStamp]
                                    userId: [[orderDictionary valueForKey: kOrderKeyUserId] intValue]
             ];
    return order;
}

@end
