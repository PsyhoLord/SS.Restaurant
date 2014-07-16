//
//  ItemOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class ItemOrderModel contains menuItems & count of it

@class MenuItemModel;

@interface OrderItemModel : NSObject

@property (strong, nonatomic) MenuItemModel *menuItemModel;
@property NSUInteger countOfItem;
@property BOOL served;

- (instancetype) initWithMenuItemModel: (MenuItemModel*)menuItemModel;

- (instancetype) init;

@end
