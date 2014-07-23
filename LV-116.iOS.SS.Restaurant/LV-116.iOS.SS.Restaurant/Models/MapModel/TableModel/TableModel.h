//
//  Table.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class WaiterTableModel;

// Table class will contains data about any of tables
@interface TableModel : NSObject

@property (assign, nonatomic) int Id;
@property (assign, nonatomic) int capacity;
@property (assign, nonatomic) int height;
@property (assign, nonatomic) BOOL isActive;
@property (assign, nonatomic) BOOL isFree;
@property (assign, nonatomic) BOOL isRound;
@property (assign, nonatomic) int rotation;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int X;
@property (assign, nonatomic) int Y;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithId:(int)Id
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

- (instancetype) initWithTableModel:(TableModel*)tableModel;

@end
