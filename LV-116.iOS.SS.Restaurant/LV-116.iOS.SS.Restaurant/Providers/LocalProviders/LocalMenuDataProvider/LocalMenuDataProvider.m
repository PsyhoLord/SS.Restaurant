//
//  LocalMenuDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalMenuDataProvider.h"

#import "LocalServiceAgent.h"

#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

static NSString *const kEntityMenuCategories = @"MenuCategories";
static NSString *const kEntityMenuItems = @"MenuItems";

static NSString *const kID          = @"id";
static NSString *const kName        = @"name";
static NSString *const kParentId    = @"parentId";
static NSString *const kPortions    = @"portions";
static NSString *const kPrice       = @"price";
static NSString *const kCategoryId  = @"categoryId";
static NSString *const kDescription = @"itemDescription";
static NSString *const kCategories  = @"categories";
static NSString *const kItems       = @"items";
static NSString *const kIsActive    = @"isActive";

@implementation LocalMenuDataProvider

// store data to local data base
+ (void) storeMenuData:(MenuModel*) menuModel
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync( concurrentQueue, ^{
        
        [LocalMenuDataProvider storeRecursivelyElementsFromCategory: menuModel.rootMenuCategory];
        
        [LocalServiceAgent save: nil];
        
    });
}

+ (void) storeRecursivelyElementsFromCategory: (MenuCategoryModel*)category
{
    [LocalMenuDataProvider storeWithMenuCategory: category];
    for ( MenuCategoryModel *subCategory in category.categories ) {
        [LocalMenuDataProvider storeRecursivelyElementsFromCategory: subCategory];
    }
    for ( MenuItemModel *subItem in category.items ) {
        [LocalMenuDataProvider storeWithMenuItem: subItem];
    }
}

+ (void) storeWithMenuCategory: (MenuCategoryModel*)menuCategory
{
    NSLog(@"%@", menuCategory.name);
    
    NSManagedObject *managedCategory = [LocalServiceAgent insertNewObjectForEntityName: kEntityMenuCategories];
    
    // set data of category by using KVC
    [managedCategory setValue: [NSNumber numberWithInt: menuCategory.Id ]
                       forKey: kID];
    [managedCategory setValue: [NSNumber numberWithInt: menuCategory.parentId ]
                       forKey: kParentId];
    [managedCategory setValue: menuCategory.name
                       forKey: kName];
}

+ (void) storeWithMenuItem: (MenuItemModel*)menuItem
{
    NSLog(@"%@", menuItem.name);
    
    NSManagedObject *managedItem = [LocalServiceAgent insertNewObjectForEntityName: kEntityMenuItems];
    
    // set data of item by using KVC
    [managedItem setValue: [NSNumber numberWithInt: menuItem.Id ]
                   forKey: kID];
    [managedItem setValue: [NSNumber numberWithInt: menuItem.categoryId ]
                   forKey: kCategoryId];
    [managedItem setValue: [NSNumber numberWithInt: menuItem.portions ]
                   forKey: kPortions];
    [managedItem setValue: [NSNumber numberWithFloat: menuItem.price ]
                   forKey: kPrice];
    [managedItem setValue: menuItem.description
                   forKey: kDescription];
    [managedItem setValue: menuItem.name
                   forKey: kName];
}

// delete all rows from entity map
+ (void) resetMenuData
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync( concurrentQueue, ^{
        
        [LocalMenuDataProvider resetMenuElementsForEntityName: kEntityMenuCategories];
        
        [LocalMenuDataProvider resetMenuElementsForEntityName: kEntityMenuItems];
        
    });
}

+ (void) resetMenuElementsForEntityName: (NSString*)entityName
{
    [LocalServiceAgent deleteDataFromEntity: entityName];
}

// load data from local data base
+ (void) loadMenuDataWithBlock: (void (^)(MenuModel*, NSError*))callback
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async( concurrentQueue, ^{
        
        MenuModel *menuModel = [LocalMenuDataProvider menuModelWithEntityCategories: kEntityMenuCategories
                                                                     andEntityItems: kEntityMenuItems];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(menuModel, nil);
        });
    });
}


#pragma mark - creation of menu model

// create menu model with data from local data base
+ (MenuModel*) menuModelWithEntityCategories: (NSString*)entityCategories andEntityItems: (NSString*)entityItems
{
    MenuModel *menuModel = [MenuModel new];
    
    // get data from local data base
    NSArray *managedCategories = [LocalServiceAgent executeFetchRequestForEntity: entityCategories
                                                                           error: nil];
    NSArray *managedItems = [LocalServiceAgent executeFetchRequestForEntity: entityItems
                                                                      error: nil];
    
    // get array of MenuCategoryModel and MenuItemModel using arrays of NSManagedObject
    NSArray *categories = [LocalMenuDataProvider getCategoriesFromManagedCategories: managedCategories];
    NSArray *items = [LocalMenuDataProvider getItemsFromManagedItems: managedItems];
    
    // create menu model with categories and items
    [LocalMenuDataProvider addElementsFromCategories: categories
                                               items: items
                                         toMenuModel: menuModel
                                  withFatherCategory: nil];
    
    
    return menuModel;
}

// creates array of MenuCategoryModel with array of managedObject from data base
+ (NSMutableArray*) getCategoriesFromManagedCategories: (NSArray*)managedCategories
{
    NSMutableArray *categories = [NSMutableArray new];
    
    for ( NSManagedObject *managedCategory in managedCategories ) {
        MenuCategoryModel *category = [[MenuCategoryModel alloc] initWithId: [[managedCategory valueForKey: kID] intValue]
                                                                       name: [managedCategory valueForKey: kName]
                                                                   parentId: [[managedCategory valueForKey: kParentId] intValue]
                                       ];
        
        [categories addObject: category];
    }
    
    return categories;
}

// creates array of MenuCategoryModel with array of managedObject from data base
+ (NSMutableArray*) getItemsFromManagedItems: (NSArray*)managedItems
{
    NSMutableArray *items = [NSMutableArray new];
    
    for ( NSManagedObject *managedItem in managedItems ) {
        MenuItemModel *item = [[MenuItemModel alloc] initWithId: [[managedItem valueForKey: kID] intValue]
                                                     categoryId: [[managedItem valueForKey: kCategoryId] intValue]
                                                    description: [managedItem valueForKey: kDescription]
                                                           name: [managedItem valueForKey: kName]
                                                       portions: [[managedItem valueForKey: kPortions] intValue]
                                                          price: [[managedItem valueForKey: kPrice] floatValue]
                               ];
        
        [items addObject: item];
    }
    
    return items;
}

// add elements (categories or items) to menu model from categories ot items according to current node (father categoty)
// recursively
+ (void) addElementsFromCategories: (NSArray*)categories items: (NSArray*)items toMenuModel: (MenuModel*)menuModel withFatherCategory: (MenuCategoryModel*)fatherCategory
{
    NSMutableArray *findCategories = [LocalMenuDataProvider findInCategories: categories byParentId: fatherCategory.Id];
    NSMutableArray *findItems = [LocalMenuDataProvider findInItems: items byCategoryId: fatherCategory.Id];
    
    [menuModel addArrayOfNodes: findCategories
              toFatherCategory: fatherCategory];
    [menuModel addArrayOfNodes: findItems
              toFatherCategory: fatherCategory];
    
    if ( fatherCategory == nil ) {
        fatherCategory = menuModel.rootMenuCategory;
        [LocalMenuDataProvider addElementsFromCategories: categories
                                                   items: items
                                             toMenuModel: menuModel
                                      withFatherCategory: fatherCategory];
    }
    
    for ( MenuCategoryModel *category in fatherCategory.categories ) {
        [LocalMenuDataProvider addElementsFromCategories: categories
                                                   items: items
                                             toMenuModel: menuModel
                                      withFatherCategory: category];
    }
}

// find categories in arr - cattegories by parentId
+ (NSMutableArray*) findInCategories: (NSArray*)categories byParentId: (NSUInteger)parentId
{
    NSMutableArray *findCategories;
    
    for ( MenuCategoryModel *category in categories ) {
        if ( category.parentId == parentId ) {
            if ( findCategories == nil ) {
                findCategories = [NSMutableArray new];
            }
            [findCategories addObject: category];
        }
    }
    
    return findCategories;
}

// find items in arr - items by categoryId
// return array of items
+ (NSMutableArray*) findInItems: (NSArray*)items byCategoryId: (NSUInteger)categoryId
{
    NSMutableArray *findItems;
    
    for ( MenuItemModel *item in items ) {
        if ( item.categoryId == categoryId ) {
            if ( findItems == nil ) {
                findItems = [NSMutableArray new];
            }
            [findItems addObject: item];
        }
    }
    
    return findItems;
}

// check is data in local data base
+ (BOOL) isData
{
    return ( [LocalServiceAgent isDataInEntity: kEntityMenuCategories]
            && [LocalServiceAgent isDataInEntity:kEntityMenuItems] );
}

@end
