//
//  CategoryCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 19.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuCategoryCell.h"
#import "MenuCategoryModel.h"

@implementation MenuCategoryCell

- (void) drawCellWithModel: (MenuCategoryModel*)menuCategoryModel
{
    _categoryName.text = menuCategoryModel.name;
}


@end
