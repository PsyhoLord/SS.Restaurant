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

static NSString *const ID          = @"Id";
static NSString *const Name        = @"Name";
static NSString *const ParentId    = @"ParentId";
static NSString *const Portions    = @"Portions";
static NSString *const Price       = @"Price";
static NSString *const CategoryId  = @"CategoryId";
static NSString *const Description = @"Description";
static NSString *const Categories  = @"Categories";
static NSString *const Items       = @"Items";
static NSString *const IsActive    = @"IsActive";

@implementation MenuDataParser

// parse all menu tree
// (NSData*) data - data to parse
+ (id)parse:(NSData*) data parseError:(NSError**)parseError
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
    if ( [menuCategoriesDictionary count] == 0 ){
        return;
    }
    
    for ( NSMutableDictionary *menuCategoryDictionary in menuCategoriesDictionary ) {
        
        MenuCategoryModel *menuCategoryModel = [MenuDataParser createMenuCategoryModel:menuCategoryDictionary];
        [menuModel addNode: menuCategoryModel toCategory: topMenuCategoryModel];
        
        if ( [[menuCategoryDictionary valueForKey:Categories] count] != 0 ) {
            // recursivly calling parseMenuDictionary
            [MenuDataParser parseMenuDictionary: [menuCategoryDictionary valueForKey:Categories]
                                    toMenuModel: menuModel
                       withTopMenuCategoryModel: menuCategoryModel];
        } else {
            if ( [[menuCategoryDictionary valueForKey:Items] count] != 0 ) {
                for ( NSMutableDictionary *menuItemDictionary in [menuCategoryDictionary valueForKey: Items] ) {
                    
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
    if ( [menuCategoryDictionary objectForKey: ParentId] != [NSNull null] ) {
        parentId = [[menuCategoryDictionary valueForKey: ParentId] intValue];
    }
    
    return [[MenuCategoryModel alloc] initWithId: [[menuCategoryDictionary valueForKey: ID] intValue]
                                            name: [menuCategoryDictionary valueForKey: Name]
                                        parentId: parentId];
}

+ (MenuItemModel*)createMenuItemModel:(NSMutableDictionary *) menuItemDictionary
{
    NSString *description = [[NSString alloc] init];
    if ( [menuItemDictionary objectForKey: Description] != [NSNull null] ) {
        description = [menuItemDictionary valueForKey: Description];
    }
    
    return [[MenuItemModel alloc] initWithId: [[menuItemDictionary valueForKey:ID] integerValue]
                                  categoryId: [[menuItemDictionary valueForKey:CategoryId] integerValue]
                                 description: description
                                        name: [menuItemDictionary valueForKey:Name]
                                    portions: [[menuItemDictionary valueForKey:Portions] integerValue]
                                       price: [[menuItemDictionary valueForKey:Price] floatValue]];
}


@end
