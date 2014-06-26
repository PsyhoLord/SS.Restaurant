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
+ (id)parse:(NSData*) data
{
    NSError *parsingError;
    NSMutableDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error: &parsingError];
    MenuModel *menuModel = [[MenuModel alloc] init];
    // parsing
    [MenuDataParser parseDictionary:response toMenuModel:menuModel withTopMenuCategory:nil];
    return menuModel;
}

// recursive method for building menu tree
+ (void)parseDictionary:(NSMutableDictionary*)category toMenuModel:(MenuModel*)menuModel withTopMenuCategory:(MenuCategoryModel*)topMenuCategory
{
    if ( [category count] == 0 )
        return;
    
    for ( NSMutableDictionary *tmpCategory in category ) {
        MenuCategoryModel *tmpTopMenuCategory = topMenuCategory;
        
        int parentId = 0;
        if ( [tmpCategory objectForKey:ParentId] != [NSNull null] ) {
            parentId = [[tmpCategory valueForKey:ParentId] intValue];
        }
        
        MenuCategoryModel *menuCategory = [[MenuCategoryModel alloc] initWithId:[[tmpCategory valueForKey:ID] intValue]
                                                                 name:[tmpCategory valueForKey:Name]
                                                             parentId:parentId
                                      ];
        [menuModel addNode:menuCategory toCategory:topMenuCategory];
        tmpTopMenuCategory = menuCategory;
        if ( [[tmpCategory valueForKey:Categories] count] != 0 ) {
            [MenuDataParser parseDictionary: [tmpCategory valueForKey:Categories] toMenuModel:menuModel withTopMenuCategory:tmpTopMenuCategory];
        } else {
            if ( [[tmpCategory valueForKey:Items] count] != 0 ) {
                for ( NSMutableDictionary *tmpItem in [tmpCategory valueForKey:Items] ) {
                    
                    NSString *description = [[NSString alloc] init];
                    if ( [tmpItem objectForKey:Description] != [NSNull null] ) {
                        description = [tmpItem valueForKey:Description];
                    }
                    
                    MenuItemModel *menuItem = [[MenuItemModel alloc] initWithId:[[tmpItem valueForKey:ID] integerValue]
                                                           categoryId:[[tmpItem valueForKey:CategoryId] integerValue]
                                                          description:description
                                                                 name:[tmpItem valueForKey:Name]
                                                             portions:[[tmpItem valueForKey:Portions] integerValue]
                                                                price:[[tmpItem valueForKey:Price] floatValue]];
                    [menuModel addNode:menuItem toCategory:tmpTopMenuCategory];
                }
            }
        }
    }
}

@end
