//
//  Table.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

// Table class will contains data about any of tables
@interface TableModel : NSObject

@property int capacity;
@property int height;
@property int width;
@property int X;
@property int Y;

@property BOOL isFree;
@property BOOL isActive;
@property BOOL isRound;

-(instancetype)initWithCapacity:(int)capacity
                         height:(int)height
                          width:(int)width
                         coordX:(int)X
                         coordY:(int)Y
                         isFree:(BOOL)isFree
                       isActive:(BOOL)isActive
                        isRound:(BOOL)isRound;

@end
