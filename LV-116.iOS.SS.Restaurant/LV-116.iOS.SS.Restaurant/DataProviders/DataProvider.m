//
//  DataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "DataProvider.h"
#import "MenuModel.h"

@implementation DataProvider
{
    MenuModel           *_menuModel;
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

-(void)createMenuModel
{
    [_remoteDataProvider getEntireMenuDataWithResponseBlock:^(MenuModel *menuModel, NSError *error) {
        
        _menuModel = menuModel;
        _currentCategory = [_menuModel getMenuData:nil];
        
    }];
}

-(MenuCategory*)getMenuData:(MenuCategory*)category
{
    if ( _menuModel ) {
        if ( category ) {
            _currentCategory = [_menuModel getMenuData:category];
        }
    } else {
        [self createMenuModel];
    }
    return _currentCategory;
}

-(MenuCategory*)getMenuData:(MenuCategory*)category FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback
{
    if ( category ) {
        _currentCategory = category;
    } else {
        _currentCategory = [[MenuCategory alloc] initWithId:1 name:@"menu" parentId:0];
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
