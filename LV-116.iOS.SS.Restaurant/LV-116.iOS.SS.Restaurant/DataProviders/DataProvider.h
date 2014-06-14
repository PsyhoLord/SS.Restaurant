//
//  DataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteDataProvider.h"
#include "MenuCategory.h"
#import "PMenuDataNotification.h"
// Test commit
@interface DataProvider : NSObject

-(void)setDelegate:(id<PMenuDataNotification>)newDelegate;

-(MenuCategory*)getMenuData:(MenuCategory*)category;

-(MenuCategory*)getMenuData:(MenuCategory*)category FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback;


@end
