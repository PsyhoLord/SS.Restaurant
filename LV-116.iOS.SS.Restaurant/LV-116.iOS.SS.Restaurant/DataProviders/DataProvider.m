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
    //    id<PMenuDataNotification> _delegate;
}

-(instancetype) init
{
    if ( self = [super init] ) {
        _remoteDataProvider = [[RemoteDataProvider alloc] init];
    }
    return self;
}

//-(void)setDelegate:(id<PMenuDataNotification>)newDelegate
//{
//    _delegate = newDelegate;
//}

// send broadcast notification notificationNameMenuTreeIsFinished
// called when it has already created menu tree ( _menuModel )
-(void) broadcastMenuTreeIsFinishedNotification
{
    NSNotification *notificationMenuTreeIsFinished = [NSNotification notificationWithName:notificationNameMenuTreeIsFinished object:self];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificationMenuTreeIsFinished];
}

// create menu tree asynchronously
// it asks _remoteDataProvider to get all data
-(void) createMenuModel
{
    [_remoteDataProvider getEntireMenuDataWithResponseBlock:^(MenuModel *menuModel, NSError *error) {
        
        _menuModel = menuModel;
        _currentCategory = [_menuModel getMenuData:nil];
        //        [_delegate didFinishMenuTree];
        [self broadcastMenuTreeIsFinishedNotification];
    }];
}

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data if it hasn't data
// if it has data than it asks _menuModel to get menu data
// (MenuCategory*)category - pointer to an category we want to get in
-(MenuCategory*) getMenuData:(MenuCategory*)category
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

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data any time we want to get menu data
// (MenuCategory*)category - pointer to an category we want to get in
// FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback - block that will called when it is menu data of current category
-(MenuCategory*) getMenuData:(MenuCategory*)category FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback
{
    if ( category ) {
        _currentCategory = category;
    } else {
        _currentCategory = [[MenuCategory alloc] initWithId:1 name:@"menu" parentId:0];
    }
    
    if ( false == [_currentCategory isItems] ) {
        [_remoteDataProvider getMenuData:_currentCategory.Id responseBlock:^(NSMutableArray *arrCategories, NSError *error) {
            
            _currentCategory.categories = arrCategories;
            // call block from high layer
            callback(_currentCategory, error);
            
        }];
    } else {
        callback(_currentCategory, nil);
    }
    
    return _currentCategory;
}

@end
