//
//  CategoryCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 19.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class MenuCategoryCell needs for custom category cell

@class MenuCategoryModel;

@interface MenuCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryName;

- (void) drawCellWithModel: (MenuCategoryModel*)menuCategoryModel;

@end
