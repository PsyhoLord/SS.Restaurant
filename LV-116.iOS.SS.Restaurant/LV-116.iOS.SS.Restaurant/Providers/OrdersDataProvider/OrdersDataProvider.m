//
//  TableOrdersProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersDataProvider.h"
#import "RemoteOrdersDataProvider.h"

#import "MapModel.h"


@implementation OrdersDataProvider

// load remote data of orders on one table using tableId
// call block when model have created
+ (void)loadTableOrdersDataWithTableId:(int)tableId andWithBlock:(void (^)(NSArray*, NSError*))callback
{
    [RemoteOrdersDataProvider loadTableOrdersWithId: (int)tableId
                                          withBlock: ^(NSArray *arrayOfOrderModel, NSError *error) {
                                              callback(arrayOfOrderModel, error);
                                          }
     ];
}

@end
