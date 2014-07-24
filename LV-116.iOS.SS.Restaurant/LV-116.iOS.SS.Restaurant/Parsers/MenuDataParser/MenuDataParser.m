//
//  MenuDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuDataParser.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

static NSString *const kMenuID      = @"Id";
static NSString *const kName        = @"Name";
static NSString *const kParentId    = @"ParentId";
static NSString *const kPortions    = @"Portions";
static NSString *const kPrice       = @"Price";
static NSString *const kCategoryId  = @"CategoryId";
static NSString *const kDescription = @"Description";
static NSString *const kCategories  = @"Categories";
static NSString *const kItems       = @"Items";
static NSString *const kIsActive    = @"IsActive";

@implementation MenuDataParser

// parse all menu tree
// (NSData*) data - data to parse
+ (id)parse:(NSData*) data parsingError:(NSError**)parseError
{
    NSError *parsingError;
    
    NSMutableDictionary *menuDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    MenuModel *menuModel = [[MenuModel alloc] init];
    // parsing
    [MenuDataParser parseMenuDictionary: menuDictionary toMenuModel: menuModel withTopMenuCategoryModel: nil];
    return menuModel;
}

// recursive method for building menu tree
// this method creates nodes ( menuItemModel or menuCategoryModel )
// and add it
+ (void)parseMenuDictionary:(NSMutableDictionary*)menuCategoriesDictionary toMenuModel:(MenuModel*)menuModel withTopMenuCategoryModel:(MenuCategoryModel*)topMenuCategoryModel
{
    if ( [menuCategoriesDictionary count] == 0 ) {
        return;
    }
    
    for ( NSMutableDictionary *menuCategoryDictionary in menuCategoriesDictionary ) {
        
        MenuCategoryModel *menuCategoryModel = [MenuDataParser createMenuCategoryModel:menuCategoryDictionary];
        [menuModel addNode: menuCategoryModel toCategory: topMenuCategoryModel];
        
        if ( [[menuCategoryDictionary objectForKey:kCategories] count] != 0 ) {
            // recursivly calling parseMenuDictionary
            [MenuDataParser parseMenuDictionary: [menuCategoryDictionary objectForKey:kCategories]
                                    toMenuModel: menuModel
                       withTopMenuCategoryModel: menuCategoryModel];
        } else {
            if ( [[menuCategoryDictionary objectForKey:kItems] count] != 0 ) {
                for ( NSMutableDictionary *menuItemDictionary in [menuCategoryDictionary objectForKey: kItems] ) {
                    
                    MenuItemModel *menuItemModel = [self createMenuItemModel: menuItemDictionary];
                    [menuModel addNode: menuItemModel toCategory: menuCategoryModel];
                    
                }
            }
        }
    }
}

+ (MenuCategoryModel*)createMenuCategoryModel:(NSMutableDictionary *) menuCategoryDictionary
{
    int parentId = 0;
    if ( [menuCategoryDictionary objectForKey: kParentId] != [NSNull null] ) {
        parentId = [[menuCategoryDictionary objectForKey: kParentId] intValue];
    }
    
    return [[MenuCategoryModel alloc] initWithId: [[menuCategoryDictionary objectForKey: kMenuID] intValue]
                                            name: [menuCategoryDictionary objectForKey: kName]
                                        parentId: parentId];
}

+ (MenuItemModel*)createMenuItemModel:(NSMutableDictionary *) menuItemDictionary
{
    NSString *description = [[NSString alloc] init];
    if ( [menuItemDictionary objectForKey: kDescription] != [NSNull null] ) {
        description = [menuItemDictionary objectForKey: kDescription];
    }
    
    return [[MenuItemModel alloc] initWithId: [[menuItemDictionary objectForKey:kMenuID] integerValue]
                                  categoryId: [[menuItemDictionary objectForKey:kCategoryId] integerValue]
                                 description: description
                                        name: [menuItemDictionary objectForKey:kName]
                                    portions: [[menuItemDictionary objectForKey:kPortions] integerValue]
                                       price: [[menuItemDictionary objectForKey:kPrice] floatValue]];
}


@end
