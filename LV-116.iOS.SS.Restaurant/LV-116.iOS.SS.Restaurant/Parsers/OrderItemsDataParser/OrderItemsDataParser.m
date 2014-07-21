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
    NSMutableArray *arrayOfOrderItems = [[NSMutableArray alloc] init];
    
    for ( NSMutableDictionary *orderItem in orderItemsDictionary) {
        
        OrderItemModel *orderItemModel = [[OrderItemModel alloc] init];
        
        orderItemModel.ID       = [[orderItem valueForKey: kOrderId] longValue];
        orderItemModel.amount   = [[orderItem valueForKey: kOrderAmount] intValue]; //Really it needed???
        
        NSMutableDictionary *menuItemFromOrder = [orderItem valueForKey: kOrderMenuItem];
        orderItemModel.menuItemModel = [[MenuItemModel alloc] initWithId: [[menuItemFromOrder valueForKey: kOrderId] longValue]
                                                              categoryId: [[menuItemFromOrder valueForKey: kOrderCategoryId] intValue]
                                                             description: [menuItemFromOrder  valueForKey: kOrderDescription]
                                                                    name: [menuItemFromOrder  valueForKey: kOrderName]
                                                                portions: [[menuItemFromOrder valueForKey: kOrderPortions] floatValue]
                                                                   price: [[menuItemFromOrder valueForKey: kOrderPrice] floatValue]
                                        ];
        orderItemModel.served   = [[orderItem valueForKey: kOrderServed] boolValue];
        
        [arrayOfOrderItems addObject: orderItemModel];
    }
    return arrayOfOrderItems;
    
}


//Making NSData object (in server needed format) from OrderModel object
+ (NSData*) unParseOrder: (OrderModel*) orderModel
{
    NSDictionary *menuItemFromOrder;
    NSDictionary *menuItemFromOrderSecond;
    NSDictionary *menuItemFromOrderThird;
    
    NSMutableArray *keysArrayFirst = [[NSMutableArray alloc] initWithObjects: @"Id",@"Closed", @"Items", @"TableId", @"Timestamp", @"UserId", nil];
    NSMutableArray *valuesArrayFirst = [[NSMutableArray alloc] initWithObjects:  [NSString stringWithFormat:@"%i",orderModel.Id],
                                                                            [NSString stringWithFormat:@"%i",orderModel.closed],
                                                                            nil
                                        ];
    NSMutableArray *ItemsDictionaryArray = [[NSMutableArray alloc] init];
    
    for (OrderItemModel *orderItem in orderModel.arrayOfOrderItems) {
        
        NSMutableArray *keysArraySecond = [[NSMutableArray alloc] init];
        NSMutableArray *valuesArraySecond = [[NSMutableArray alloc] init];
        
        OrderItemModel *currentOrderItem;
        
        currentOrderItem = orderItem;
        
        [keysArraySecond addObjectsFromArray: @[@"Id", @"ActualPrice", @"Amount", @"MenuItem", @"MenuItemId", @"OrderId", @"Served"]];
        
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%ld", currentOrderItem.ID] ];
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%f", currentOrderItem.actualPrice] ];
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%d", currentOrderItem.amount] ];
        
            MenuItemModel *menuItem = orderItem.menuItemModel;
           // NSMutableArray *keysArrayThird = [[NSMutableArray alloc] init];
           // NSMutableArray *valuesArrayThird = [[NSMutableArray alloc] init];
           // [keysArrayThird addObjectsFromArray: @[@"Id", @"CategoryId", @"Description", @"IsActive", @"Name", @"Portions", @"Price"]];
        /*
            [valuesArrayThird addObject: [NSString stringWithFormat: @"%ld", menuItem.Id] ];
            [valuesArrayThird addObject: [NSString stringWithFormat: @"%ld", menuItem.categoryId] ];
            [valuesArrayThird addObject: menuItem.description];
            [valuesArrayThird addObject: @"1"];
            [valuesArrayThird addObject: menuItem.name];
            [valuesArrayThird addObject: [NSString stringWithFormat: @"%ld", menuItem.portions] ];
            [valuesArrayThird addObject: [NSString stringWithFormat: @"%f", menuItem.price] ];*/
        
        //menuItemFromOrderThird = @[];//[[NSDictionary alloc] initWithObjects: valuesArrayThird forKeys: keysArrayThird];
        
        [valuesArraySecond addObject: @[]];
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%ld", menuItem.Id] ];
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%d", orderModel.Id] ];
        [valuesArraySecond addObject: [NSString stringWithFormat: @"%i", currentOrderItem.served] ];
        
        menuItemFromOrderSecond = [[NSDictionary alloc] initWithObjects: valuesArraySecond forKeys: keysArraySecond];
        [ItemsDictionaryArray addObject: menuItemFromOrderSecond];
    }
    
    [valuesArrayFirst addObject: ItemsDictionaryArray];
    [valuesArrayFirst addObject: [NSString stringWithFormat: @"%d", orderModel.Id] ];
    [valuesArrayFirst addObject: orderModel.timestamp];
    [valuesArrayFirst addObject: [NSString stringWithFormat: @"%d", orderModel.userId] ];
    
    menuItemFromOrder = [[NSDictionary alloc] initWithObjects: valuesArrayFirst forKeys: keysArrayFirst];
    
    NSData *data=[ParserToJSON createJSONDataWithObjects: valuesArrayFirst keys: keysArrayFirst];
    
    return data;
    
    
}

@end