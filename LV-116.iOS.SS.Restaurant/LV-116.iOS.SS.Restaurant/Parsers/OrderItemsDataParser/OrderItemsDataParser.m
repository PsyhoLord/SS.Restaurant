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

@implementation OrderItemsDataParser


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


+ (NSMutableArray*)parseDictionary:(NSMutableDictionary*) orderItemsDictionary
{
    NSMutableArray *arrayOfOrderItems = [[NSMutableArray alloc] init];
    
    for ( NSMutableDictionary *orderItem in orderItemsDictionary) {
        
        OrderItemModel *orderItemModel = [[OrderItemModel alloc] init];
        
        orderItemModel.countOfItem  = [[orderItem valueForKey: @"Amount"] intValue];
        orderItemModel.served       = [[orderItem valueForKey: @"Served"] boolValue];
        NSMutableDictionary *menuItemFromOrder = [orderItem valueForKey: @"MenuItem"];
        orderItemModel.menuItemModel = [[MenuItemModel alloc] initWithId: [[menuItemFromOrder valueForKey: @"Id"] intValue]
                                                              categoryId: [[menuItemFromOrder valueForKey: @"CategoryId"] intValue]
                                                             description: [menuItemFromOrder valueForKey: @"Description"]
                                                                    name: [menuItemFromOrder valueForKey: @"Name"]
                                                                portions: [[menuItemFromOrder valueForKey: @"Portions"] floatValue]
                                                                   price: [[menuItemFromOrder valueForKey: @"Price"] floatValue]
                                        ];
        [arrayOfOrderItems addObject: orderItemModel];
    }
    return arrayOfOrderItems;
    
}

@end
