//
//  MenuModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

@implementation MenuModel
{
    // root of menu tree
//    MenuCategoryModel *_rootMenuCategory;
}

- (instancetype)init
{
    if ( self = [super init] ) {
        
    }
    return self;
}

- (BOOL)isEmpty
{
    return  ( ( _rootMenuCategory == nil ) && ( [_rootMenuCategory isCategories] == 0 ) && ( [_rootMenuCategory isItems] == 0 ) );
}

// get MenuCategory object which contains categories or items of current category we want to get in
- (MenuCategoryModel*)getMenuData:(MenuCategoryModel*)category
{
    if ( [self isEmpty] ) {
        return nil;
    } else if ( category ) {
        return category;
    } else {
        return _rootMenuCategory;
    }
}

// add category or item to menu tree
// needs for DataParser
- (void)addNode:(id)node toCategory:(MenuCategoryModel*)nodeFather
{
    if ( nodeFather ) {
        if ( [node isKindOfClass:([MenuCategoryModel class])] ) {
            [nodeFather addCategory:node];
        } else if ( [node isKindOfClass:([MenuItemModel class])] ) {
            [nodeFather addItem:node];
        }
    } else {
        //        [_entireMenuCategory addCategory:node];
        _rootMenuCategory = node;
    }
}

@end
