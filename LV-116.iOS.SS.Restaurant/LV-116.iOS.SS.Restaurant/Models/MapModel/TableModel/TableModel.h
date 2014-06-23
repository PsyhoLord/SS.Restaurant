//
//  Table.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// Table class will contains data about any of tables
@interface TableModel : NSObject

@property int Id;
@property int capacity;
@property int height;
@property BOOL isActive;
@property BOOL isFree;
@property BOOL isRound;
@property (strong, nonatomic) NSString *name;
@property int rotation;
@property int width;
@property int X;
@property int Y;

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
                   coordY:(int)Y;

@end
