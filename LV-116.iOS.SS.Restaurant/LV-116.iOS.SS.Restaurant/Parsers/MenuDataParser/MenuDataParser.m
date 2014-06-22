//
//  MenuDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuDataParser.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

NSString *const ID          = @"Id";
NSString *const Name        = @"Name";
NSString *const ParentId    = @"ParentId";
NSString *const Portions    = @"Portions";
NSString *const Price       = @"Price";
NSString *const CategoryId  = @"CategoryId";
NSString *const Description = @"Description";
NSString *const Categories  = @"Categories";
NSString *const Items       = @"Items";
NSString *const IsActive    = @"IsActive";

@implementation MenuDataParser

// parse all menu tree
// (NSData*) data - data to parse
+(MenuModel*) parseEntireMenu:(NSData*) data
{
    NSError *parsingError;
    NSMutableDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error: &parsingError];
    MenuModel *entireMenuModel = [[MenuModel alloc] init];
    // parsing
    [MenuDataParser parseDictionary:response toMenuModel:entireMenuModel withTopMenuCategory:nil];
    return entireMenuModel;
}


// recursive method for building menu tree
+(void)parseDictionary:(NSMutableDictionary*)category toMenuModel:(MenuModel*)menuModel withTopMenuCategory:(MenuCategoryModel*)topMenuCategory
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

// parse data for current category
// (NSData*) data - data to parse
+(NSMutableArray*)parseCurrentCategory:(NSData*)data
{
    NSError *parsingError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingMutableContainers
                                                                                error: &parsingError];
    // parsing
    NSMutableArray *menu = [[NSMutableArray alloc] init];
    
    for(NSMutableDictionary *category in responseDictionary){
        
        int parentId = 0;
        if ( [category objectForKey:ParentId] != [NSNull null] ) {
            parentId = [[category valueForKey:ParentId] intValue];
        }
        MenuCategoryModel *menuCategory = [[MenuCategoryModel alloc] initWithId:[[category valueForKey:ID] intValue]
                                                                 name:[category  valueForKey:Name]
                                                             parentId:parentId];
        [menu addObject:menuCategory];
        
        if([[category valueForKey:Items] count] != 0){
            for(NSMutableArray *item in [category valueForKey:Items] ) {
                
                NSString *description = [[NSString alloc] init];
                if ( [item valueForKey:Description] != [NSNull null] ) {
                    description = [item valueForKey:Description];
                }
                
                MenuItemModel *menuItem =[ [MenuItemModel alloc] initWithId:[[item valueForKey:ID] intValue]
                                                       categoryId:[[item valueForKey:CategoryId] intValue]
                                                      description:description
                                                             name:[item valueForKey:Name]
                                                         portions:[[item valueForKey:Portions] intValue]
                                                            price:[[item valueForKey:Price] floatValue]];
                
                if ( [[item valueForKey:IsActive] boolValue] == YES ) {
                    [menuCategory addItem:menuItem];
                }
                
            }
        }
    }
    return menu;
}


@end
