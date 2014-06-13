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

@interface MenuModel : NSObject

-(BOOL)isEmpty;

-(MenuCategory*)getMenuData:(MenuCategory*)category;

-(void)addNode:(id)node toCategory:(MenuCategory*)nodeFather;

@end
