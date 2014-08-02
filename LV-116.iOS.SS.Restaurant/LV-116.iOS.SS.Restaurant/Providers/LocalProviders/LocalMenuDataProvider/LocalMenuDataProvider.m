//
//  LocalMenuDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalMenuDataProvider.h"

#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

static NSString *const kEntityMenuCategories = @"MenuCategories";
static NSString *const kEntityMenuItems = @"MenuItems";

@implementation LocalMenuDataProvider

// store data to local data base
+ (void) storeMenuData:(MenuModel*) menuModel
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async( concurrentQueue, ^{
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        
        [LocalMenuDataProvider storeElementRecursively: menuModel.rootMenuCategory];
        
        [managedObjectContext save: nil];
    });
}

+ (void) storeElementRecursively:(MenuCategoryModel*)category
{
    
}

//+ (NSManagedObject*) insertCategory: (MenuCategoryModel*)managedMenuCategory
//                          forEntity: (NSString*)entity
//             inManagedObjectContext: (NSManagedObjectContext*)managedObjectContext
//{
//    
////    NSManagedObject *newTable = [NSEntityDescription insertNewObjectForEntityForName: entity
////                                                              inManagedObjectContext: managedObjectContext];
//}

+ (void) storeItem:(NSManagedObject*)managedMenuItem
{
//    // Create a new managed object and insert it to local data base
//    [LocalMenuDataProvider insertTable: managedMenuItem
//                             forEntity: kEntityMenuCategories
//                inManagedObjectContext: managedObjectContext];
}



// delete all rows from entity map
+ (void) resetMenuData
{
    
}

// load data from local data base
+ (void) loadMenuDataWithBlock: (void (^)(MenuModel*, NSError*))callback
{
    
}

// check is data in local data base
+ (BOOL) isData
{
    return NO;
}

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
