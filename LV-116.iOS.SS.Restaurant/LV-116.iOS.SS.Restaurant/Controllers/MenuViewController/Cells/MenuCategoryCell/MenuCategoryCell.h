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

@property (weak, nonatomic) IBOutlet UIImageView *pointingImage;
@property (weak, nonatomic) IBOutlet UILabel     *categoryName;

// this method draws category cell with data menuCategoryModel
// (MenuCategoryModel*)menuCategoryModel - data for category cell
- (void) drawCellWithModel:(MenuCategoryModel*)menuCategoryModel;

+ (CGFloat) rowHeightForCell;
@end
