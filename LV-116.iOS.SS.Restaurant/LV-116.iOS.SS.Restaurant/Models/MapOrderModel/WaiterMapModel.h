//
//  MapOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MapModel;
@class WaiterTableModel;
@class MenuItemModel;

@interface WaiterMapModel : NSObject

@property (strong, nonatomic) NSMutableArray *arrayOfTableModel;

- (instancetype) initWithMapModel:(MapModel*)mapModel;

@end
