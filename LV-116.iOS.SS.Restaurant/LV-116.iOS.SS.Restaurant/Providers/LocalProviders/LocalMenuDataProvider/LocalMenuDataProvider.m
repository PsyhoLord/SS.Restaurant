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

static NSString *const kID      = @"id";
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
    dispatch_async( concurrentQueue, ^{
        
        [LocalMenuDataProvider storeRecursivelyElementsFromCategory: menuModel.rootMenuCategory];
        
        [LocalServiceAgent save: nil];
        
    });
}

+ (void) storeRecursivelyElementsFromCategory: (MenuCategoryModel*)category
{
    [LocalMenuDataProvider storeWithMenuCategory: category];
    if ( [category isCategories] ) {
        for ( MenuCategoryModel *subCategory in category.categories ) {
            [LocalMenuDataProvider storeRecursivelyElementsFromCategory: subCategory];
        }
    } else {
        for ( MenuItemModel *subItem in category.items ) {
            [LocalMenuDataProvider storeWithMenuItem: subItem];
        }
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
    dispatch_async( concurrentQueue, ^{
        
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
    // tests ...
    NSArray *categories = [LocalServiceAgent executeFetchRequestForEntity: kEntityMenuCategories
                                                                    error: nil];
    
    for ( id category in categories ) {
        NSLog(@"%@", [category valueForKey: @"name"]);
    }
}

// check is data in local data base
+ (BOOL) isData
{
    return ( [LocalServiceAgent isDataInEntity: kEntityMenuCategories]
            && [LocalServiceAgent isDataInEntity:kEntityMenuItems] );
}

@end
