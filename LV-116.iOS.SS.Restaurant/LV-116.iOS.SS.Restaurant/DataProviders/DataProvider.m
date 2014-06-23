//
//  DataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "DataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"
#import "MapModel.h"
#import "TableModel.h"

NSString *const notificationNameMenuTreeIsFinished      = @"notificationMenuTreeIsFinished";
NSString *const notificationItemImageDownloadIsFinished = @"notificationItemImageDownloadIsFinished";
NSString *const menuItemKey                             = @"menuItem";
NSString *const menuCellIndexKey                        = @"cellIndex";
NSString *const notificationNameMapIsFinished           = @"notificationNameMapIsFinished";

@implementation DataProvider
{
    MenuModel           *_menuModel;
    MapModel            *_mapModel;
    MenuCategoryModel   *_currentCategory;
    RemoteDataProvider  *_remoteDataProvider;
}

- (instancetype)init
{
    if ( self = [super init] ) {
        _remoteDataProvider = [[RemoteDataProvider alloc] init];
    }
    return self;
}

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data if it hasn't data
// if it has data than it asks _menuModel to get menu data
// (MenuCategory*)category - pointer to an category we want to get in
- (MenuCategoryModel*)getMenuData:(MenuCategoryModel*)category
{
    if ( _menuModel ) {
        if ( category ) {
            _currentCategory = [_menuModel getMenuData:category];
            
            if ( _currentCategory.items && [((MenuItemModel*)[_currentCategory.items objectAtIndex:0]) isImage] ) {
                for ( int i = 0; i <  [_currentCategory.items count]; ++i ) {
                    MenuItemModel *item = [_currentCategory.items objectAtIndex:i];
                    [self downloadImageForItem:item cellIndex:i];
                }
            }
        }
    } else {
        [self createMenuModel];
    }
    return _currentCategory;
}


// get object of MapModel which contains array of TableModels
-(MapModel*) getMapData
{
    if (!_mapModel)
        [self createMapModel];
    return _mapModel;
}




//(creates a table map from remoteDataProvider);
-(void) createMapModel
{
    [_remoteDataProvider getEntireMapDataWithResponseBlock:^(MapModel *mapModel, NSError *error)
        {
            _mapModel=mapModel;
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameMapIsFinished object:self];
            
        }
    ];
}

// create menu tree asynchronously
// it asks _remoteDataProvider to get all data
- (void)createMenuModel
{
    [_remoteDataProvider getEntireMenuDataWithResponseBlock:[^(MenuModel *menuModel, NSError *error) {
        
        _menuModel = menuModel;
        _currentCategory = [_menuModel getMenuData:nil];
        // post notification that menu data is
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameMenuTreeIsFinished object:self];
        
    } copy] ];
}

// get MenuCategory object which contains categories or items of current category we want to get in
// it asks _remoteDataProvider to get menu data any time we want to get menu data
// (MenuCategory*)category - pointer to an category we want to get in
// FromNetWithResponseBlock:(void (^)(MenuCategory*, NSError*))callback - block that will called when it is menu data of current category
- (MenuCategoryModel*)getMenuData:(MenuCategoryModel*)category FromNetWithResponseBlock:(void (^)(MenuCategoryModel*, NSError*))callback
{
    if ( category ) {
        _currentCategory = category;
    } else {
        _currentCategory = [[MenuCategoryModel alloc] initWithId:1 name:@"menu" parentId:0];
    }
    
    if ( [_currentCategory isItems] ) {
        callback(_currentCategory, nil);
    } else {
        [_remoteDataProvider getMenuData:_currentCategory.Id responseBlock:[^(NSMutableArray *arrCategories, NSError *error) {
            
            _currentCategory.categories = arrCategories;
            // call block from high layer
            callback(_currentCategory, error);
            
        } copy] ];
    }
    
    return _currentCategory;
}

// download image for item and cell index in tableView
// (MenuItem*)item - ptr to item which need to update image
// (int)cellIndex  - index of cell in tableView
// this method posts notificationItemImageDownloadIsFinished when image has downloaded
- (void)downloadImageForItem:(MenuItemModel*)item cellIndex:(int)cellIndex
{
    [_remoteDataProvider downloadImageForItemId:item.Id withBlock:^(UIImage *itemImage, NSError *error) {
        // set image to menuItem
        item.image = itemImage;
        NSNumber *objCellIndex = [NSNumber numberWithInt:cellIndex];
        NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:item, menuItemKey,
                                  objCellIndex, menuCellIndexKey,
                                  nil];
        // post notification that image has downloaded
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationItemImageDownloadIsFinished object:self userInfo:userInfo];
    }];
}



// create menu tree asynchronously
// it asks _remoteDataProvider to get all data
/*- (void)createMapModel
{
  //  [_remoteDataProvider get]
    
    
    // hardcode :
    _mapModel = [[MapModel alloc] init];
    TableModel *tableModel;
    tableModel = [[TableModel alloc] initWithId:16 Capacity:2 height:62 isActive:YES isFree:YES isRound:YES name:@"1" rotation:0 width:58 coordX:637 coordY:118];
    [_mapModel addTableModel:tableModel];
    tableModel = [[TableModel alloc] initWithId:46 Capacity:2 height:47 isActive:YES isFree:NO isRound:NO name:@"10" rotation:0 width:50 coordX:104 coordY:207];
    [_mapModel addTableModel:tableModel];
    tableModel = [[TableModel alloc] initWithId:45 Capacity:2 height:52 isActive:YES isFree:NO isRound:YES name:@"11" rotation:0 width:57 coordX:249 coordY:299];
    [_mapModel addTableModel:tableModel];
    tableModel = [[TableModel alloc] initWithId:51 Capacity:2 height:50 isActive:YES isFree:NO isRound:NO name:@"12" rotation:0 width:40 coordX:749 coordY:226];
    [_mapModel addTableModel:tableModel];
    tableModel = [[TableModel alloc] initWithId:15 Capacity:4 height:59 isActive:YES isFree:NO isRound:YES name:@"13" rotation:0 width:57 coordX:14 coordY:49];
    [_mapModel addTableModel:tableModel];
    
//    [_remoteDataProvider getEntireMenuDataWithResponseBlock:^(MenuModel *menuModel, NSError *error) {
//        
//        _menuModel = menuModel;
//        _currentCategory = [_menuModel getMenuData:nil];
//        // post notification that menu data is
//        [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameMenuTreeIsFinished object:self];
//        
//    }];
}*/

@end
