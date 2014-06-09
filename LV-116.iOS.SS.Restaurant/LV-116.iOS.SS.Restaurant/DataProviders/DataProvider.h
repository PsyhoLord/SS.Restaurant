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

@interface DataProvider : NSObject

-(instancetype)init;

-(MenuCategory*)getMenuData:(MenuCategory*)category responseBlock:(void (^)(MenuCategory*, NSError*))callback;

@end
