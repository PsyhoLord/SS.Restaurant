//
//  MapModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class TableModel;

// MapModel class will contains an array of tables
@interface MapModel : NSObject

@property (strong, nonatomic) NSMutableArray *arrayTableModel;
@property (strong, nonatomic) UIImage        *image;

// get object of MapModel which contains array of TableModels
- (MapModel*)getMapData;

// add TableModel to an array of TableModels
- (void)addTableModel:(TableModel*)arrayOfTableModel;

@end
