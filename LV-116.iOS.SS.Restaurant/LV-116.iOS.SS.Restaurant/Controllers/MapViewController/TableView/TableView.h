//
//  TableView.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/24/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class TableModel;

// class TableView is a wrapper for table

@interface TableView : UIButton

- (id)initWithTableModel:(TableModel*)tableModel;

@end
