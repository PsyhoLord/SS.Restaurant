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

@property long ID;
@property (strong, nonatomic) MenuItemModel *menuItemModel;
@property int amount;
@property BOOL served;
@property float actualPrice;
#pragma mark Those propertis are in the model, thats sends on server
/*
need to be sure, delete them or no
@property long menuItemId;
@property long orderId;*/

- (instancetype) initWithMenuItemModel: (MenuItemModel*)menuItemModel;

- (instancetype) init;

@end
