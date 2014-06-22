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
        self.Id       = Id;
        self.capacity = capacity;
        self.height   = height;
        self.isActive = isActive;
        self.isFree   = isFree;
        self.isRound  = isRound;
        self.name     = name;
        self.rotation = rotation;
        self.width    = width;
        self.X        = X;
        self.Y        = Y;
    }
    return self;
}

@end
