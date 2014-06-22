//
//  Table.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

-(instancetype)initWithCapacity:(int)capacity
                         height:(int)height
                          width:(int)width
                         coordX:(int)X
                         coordY:(int)Y
                         isFree:(BOOL)isFree
                       isActive:(BOOL)isActive
                        isRound:(BOOL)isRound
{
    if(self = [super init]){
        self.capacity = capacity;
        self.height   = height;
        self.width    = width;
        self.X        = X;
        self.Y        = Y;
        self.isFree   = isFree;
        self.isActive = isActive;
        self.isRound  = isRound;
    }
    return self;
}

@end
