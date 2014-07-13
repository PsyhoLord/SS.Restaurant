//
//  ContainerOrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModelWithOrders.h"
#import "OrderModel.h"
#import "MapModel.h"

@implementation TableModelWithOrders

-(instancetype)initWithTableModel:(TableModel*)tableModel
{
    if( self = [super initWithTableModel: tableModel] ) {
    }
    return self;
}

// Add one order in arrayOfOrdersModel from OrderModel.
-(void)addOrder:(OrderModel*)orderModel
{
    if( self.arrayOfOrdersModel == nil ){
        self.arrayOfOrdersModel = [[NSMutableArray alloc] init];
    }
    [self.arrayOfOrdersModel addObject: orderModel];
}

// Add few orders from array in arrayOfOrdersModel.
-(void)addArrayOfOrders:(NSArray*)arrayOfOrderModel
{
    if( self.arrayOfOrdersModel == nil ){
        self.arrayOfOrdersModel = [[NSMutableArray alloc] init];
    }
    [self.arrayOfOrdersModel addObjectsFromArray: arrayOfOrderModel];

}

// Remove one order at index.
-(void)removeOrderAtIndex:(NSUInteger)index
{
    if( self.arrayOfOrdersModel != nil ){
        [self.arrayOfOrdersModel removeObjectAtIndex: index];
    }
}




@end
