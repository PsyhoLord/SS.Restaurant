//
//  ItemOrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemModel.h"

@implementation OrderItemModel

- (instancetype)initWithMenuItemModel:(MenuItemModel*)menuItemModel
{
    if ( self = [super init] ) {
        self.menuItemModel = menuItemModel;
    }
    return self;
}

@end
