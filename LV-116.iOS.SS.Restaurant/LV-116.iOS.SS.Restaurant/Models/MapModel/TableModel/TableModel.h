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

@property (assign, nonatomic, readonly) int Id;
@property (assign, nonatomic, readonly) int capacity;
@property (assign, nonatomic, readonly) int height;
@property (assign, nonatomic, readonly) BOOL isActive;
@property (assign, nonatomic, readonly) BOOL isFree;
@property (assign, nonatomic, readonly) BOOL isRound;
@property (assign, nonatomic, readonly) int rotation;
@property (assign, nonatomic, readonly) int width;
@property (assign, nonatomic, readonly) int X;
@property (assign, nonatomic, readonly) int Y;
@property (strong, nonatomic, readonly) NSString *name;

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
