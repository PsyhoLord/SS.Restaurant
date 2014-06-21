//
//  MenuModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuCategory.h"
#import "MenuItem.h"

// class MenuModel will contain all menu tree

@interface MenuModel : NSObject

-(BOOL)isEmpty;

// get MenuCategory object which contains categories or items of current category we want to get in
-(MenuCategory*)getMenuData:(MenuCategory*)category;

// add category or item to menu tree
// needs for DataParser
-(void)addNode:(id)node toCategory:(MenuCategory*)nodeFather;

@end
