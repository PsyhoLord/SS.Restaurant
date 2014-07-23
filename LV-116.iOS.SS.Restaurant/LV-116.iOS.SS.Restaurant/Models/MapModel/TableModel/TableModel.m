//
//  Table.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

-(instancetype)initWithId:(int)Id
                 Capacity:(int)capacity
                   height:(int)height
                 isActive:(BOOL)isActive
                   isFree:(BOOL)isFree
                  isRound:(BOOL)isRound
                     name:(NSString*)name
                 rotation:(int)rotation
                    width:(int)width
                   coordX:(int)X
                   coordY:(int)Y
{
    if ( self = [super init] ){
        _Id       = Id;
        _capacity = capacity;
        _height   = height;
        _isActive = isActive;
        _isFree   = isFree;
        _isRound  = isRound;
        _name     = name;
        _rotation = rotation;
        _width    = width;
        _X        = X;
        _Y        = Y;
    }
    return self;
}

// It's used for TableModelWithOrders.
- (instancetype) initWithTableModel:(TableModel*)tableModel
{
    if ( self = [super init] ){
        _Id       = tableModel.Id;
        _capacity = tableModel.capacity;
        _height   = tableModel.height;
        _isActive = tableModel.isActive;
        _isFree   = tableModel.isFree;
        _isRound  = tableModel.isRound;
        _name     = tableModel.name;
        _rotation = tableModel.rotation;
        _width    = tableModel.width;
        _X        = tableModel.X;
        _Y        = tableModel.Y;
    }
    return self;
}

@end
