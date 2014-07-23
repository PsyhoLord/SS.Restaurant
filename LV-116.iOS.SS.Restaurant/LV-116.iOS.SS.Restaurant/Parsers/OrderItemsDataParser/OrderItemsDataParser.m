//
//  OrderDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemsDataParser.h"
#import "OrderModel.h"
#import "OrderItemModel.h"

#import "MenuItemModel.h"

#import "ParserToJSON.h"

@implementation OrderItemsDataParser

static NSString *const kOrderAmount         = @"Amount";
static NSString *const kOrderServed         = @"Served";
static NSString *const kOrderMenuItem       = @"MenuItem";
static NSString *const kOrderId             = @"Id";
static NSString *const kOrderCategoryId     = @"CategoryId";
static NSString *const kOrderDescription    = @"Description";
static NSString *const kOrderName           = @"Name";
static NSString *const kOrderPortions       = @"Portions";
static NSString *const kOrderPrice          = @"Price";


//make Dictionary from JSON
+ (id)parse:(NSData *)data parsingError:(NSError *__autoreleasing *)parseError
{
    NSError *parsingError;
    
    NSMutableDictionary *responseForOrder = [NSJSONSerialization JSONObjectWithData: data
                                                                            options: NSJSONReadingMutableContainers
                                                                              error: &parsingError
                                             ];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    
    return [self parseDictionary: responseForOrder];
}


//Parsing dictionary into OrderItems array
+ (NSMutableArray*)parseDictionary:(NSMutableDictionary*) orderItemsDictionary
{
    NSMutableArray *orderItems = [[NSMutableArray alloc] init];
    
    for ( NSMutableDictionary *orderItem in orderItemsDictionary) {
        
        OrderItemModel *orderItemModel = [[OrderItemModel alloc] init];
        
        orderItemModel.Id       = [[orderItem valueForKey: kOrderId] longValue];
        orderItemModel.amount   = [[orderItem valueForKey: kOrderAmount] intValue];
        
        NSMutableDictionary *menuItemFromOrder = [orderItem valueForKey: kOrderMenuItem];
        NSString *description = [[NSString alloc] init];
        if ([menuItemFromOrder valueForKey: kOrderDescription] != [NSNull null]){
            description = [menuItemFromOrder valueForKey: kOrderDescription];
        } else {
            description = @"No info";
        }
        
        
        orderItemModel.menuItemModel = [[MenuItemModel alloc] initWithId: [[menuItemFromOrder valueForKey: kOrderId] longValue]
                                                              categoryId: [[menuItemFromOrder valueForKey: kOrderCategoryId] intValue]
                                                             description: description
                                                                    name: [menuItemFromOrder  valueForKey: kOrderName]
                                                                portions: [[menuItemFromOrder valueForKey: kOrderPortions] floatValue]
                                                                   price: [[menuItemFromOrder valueForKey: kOrderPrice] floatValue]
                                        ];
        orderItemModel.served   = [[orderItem valueForKey: kOrderServed] boolValue];
        
        [orderItems addObject: orderItemModel];
    }
    return orderItems;
    
}


//Making NSData object (in server needed format) from OrderModel object
+ (NSData*) parseOrderToData: (OrderModel*) orderModel
{
    NSDictionary *menuItemFromOrderSecond;
     
    NSMutableArray *keysArrayFirst = [[NSMutableArray alloc] initWithObjects:   @"Id",
                                                                                @"Closed",
                                                                                @"Items",
                                                                                @"TableId",
                                                                                @"Timestamp",
                                                                                @"UserId",
                                                                                nil
                                      ];
    NSMutableArray *valuesArrayFirst = [[NSMutableArray alloc] initWithObjects: [NSString stringWithFormat:@"%i",orderModel.Id],
                                                                                [NSString stringWithFormat:@"%s",(orderModel.closed ? "true" : "false")],
                                                                                nil
                                        ];
    NSMutableArray *ItemsDictionaryArray = [[NSMutableArray alloc] init];
    
    
    for (OrderItemModel *orderItem in orderModel.items) {
        
        NSMutableArray *keysArraySecond = [[NSMutableArray alloc] init];
        NSMutableArray *valuesArraySecond = [[NSMutableArray alloc] init];
        
        [keysArraySecond addObjectsFromArray: @[@"Id", @"ActualPrice", @"Amount", @"MenuItem", @"MenuItemId", @"OrderId", @"Served"]];
        
        [valuesArraySecond addObjectsFromArray:@[[NSString stringWithFormat: @"%d", orderItem.Id],
                                                 [NSString stringWithFormat: @"%f", orderItem.actualPrice],
                                                 [NSString stringWithFormat: @"%d", orderItem.amount],
                                                 @[],
                                                 [NSString stringWithFormat: @"%d", orderItem.menuItemModel.Id],
                                                 [NSString stringWithFormat: @"%d", orderModel.Id],
                                                 [NSString stringWithFormat: @"%s", (orderItem.served  ? "true" : "false")]
                                                 ]
         ];
        
        menuItemFromOrderSecond = [[NSDictionary alloc] initWithObjects: valuesArraySecond forKeys: keysArraySecond];
        [ItemsDictionaryArray addObject: menuItemFromOrderSecond];
    }
    
    [valuesArrayFirst addObject: ItemsDictionaryArray];
    [valuesArrayFirst addObject: [NSString stringWithFormat: @"%d", orderModel.tableId] ];
    [valuesArrayFirst addObject: orderModel.timestamp];
    [valuesArrayFirst addObject: [NSString stringWithFormat: @"%d", orderModel.userId] ];
    
    
    NSData *data=[ParserToJSON createJSONDataWithObjects: valuesArrayFirst keys: keysArrayFirst];
    
    return data;
    
    
}

@end