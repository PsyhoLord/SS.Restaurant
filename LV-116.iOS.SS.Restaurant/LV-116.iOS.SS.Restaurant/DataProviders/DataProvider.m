//
//  DataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "DataProvider.h"
#import "MenuCategory.h"

@implementation DataProvider
{
    MenuCategory        *_currentCategory;
    RemoteDataProvider  *_remoteDataProvider;
}

-(instancetype)init
{
    if ( self = [super init] ) {
        _remoteDataProvider = [[RemoteDataProvider alloc] init];
    }
    return self;
}

-(MenuCategory*)getMenuData:(MenuCategory*)category responseBlock:(void (^)(MenuCategory*, NSError*))callback
{
    if ( nil == category ) {
        _currentCategory = [[MenuCategory alloc] initWithId:1 name:@"menu" parentId:0];
    } else {
        _currentCategory = category;
    }
    
    if ( false == [_currentCategory isItems] ) {
        [_remoteDataProvider getMenuData:_currentCategory.Id responseBlock:^(NSMutableArray *arrCategories, NSError *error) {
            
            _currentCategory.categories = arrCategories;
            callback(_currentCategory, error);
            
        }];
    } else {
        callback(_currentCategory, nil);
    }
    
    return _currentCategory;
}

@end
