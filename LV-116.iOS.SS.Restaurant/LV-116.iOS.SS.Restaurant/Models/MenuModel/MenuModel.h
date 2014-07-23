//
//  MenuModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>


// class MenuModel will contain all menu tree
@class MenuCategoryModel;

@interface MenuModel : NSObject

@property (strong, nonatomic, readonly) MenuCategoryModel *rootMenuCategory;

- (BOOL)isEmpty;

// get MenuCategory object which contains categories or items of current category we want to get in
- (MenuCategoryModel*)getMenuData:(MenuCategoryModel*)category;

// add category or item to menu tree
// needs for DataParser
- (void)addNode:(id)node toCategory:(MenuCategoryModel*)nodeFather;

@end
