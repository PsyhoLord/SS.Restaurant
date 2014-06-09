//
//  MenuDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuDataParser.h"
#import "MenuCategory.h"
#import "MenuItem.h"

@implementation MenuDataParser

+(NSMutableArray*)parse:(NSData*)data
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
        MenuCategory *menuCategory = [[MenuCategory alloc] initWithId:[[category valueForKey:ID] intValue]
                                                                 name:[category  valueForKey:Name]
                                                             parentId:parentId];
        [menu addObject:menuCategory];
        
        if([[category valueForKey:Items] count] != 0){
            for(NSMutableArray *item in [category valueForKey:Items] ) {
                
                NSString *description = [[NSString alloc] init];
                if ( [item valueForKey:Description] != [NSNull null] ) {
                    description = [item valueForKey:Description];
                }
                
                MenuItem *menuItem =[ [MenuItem alloc] initWithId:[[item valueForKey:ID] intValue]
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
