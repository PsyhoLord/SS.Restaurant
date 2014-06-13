//
//  MenuModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/4/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel
{
    MenuCategory *_entireMenuCategory;
}

-(instancetype)init
{
    if ( self = [super init] ) {
        //        _entireMenuCategory = [[MenuCategory alloc] init];
    }
    return self;
}

-(BOOL)isEmpty
{
    return  ( ( _entireMenuCategory == nil ) && ( [_entireMenuCategory isCategories] == 0 ) && ( [_entireMenuCategory isItems] == 0 ) );
}

-(MenuCategory*)getMenuData:(MenuCategory*)category
{
    if ( [self isEmpty] ) {
        return nil;
    } else if ( category ) {
        return category;
    } else {
        return _entireMenuCategory;
    }
}

-(void)addNode:(id)node toCategory:(MenuCategory*)nodeFather
{
    if ( nodeFather ) {
        if ( [node isKindOfClass:([MenuCategory class])] ) {
            [nodeFather addCategory:node];
        } else if ( [node isKindOfClass:([MenuItem class])] ) {
            [nodeFather addItem:node];
        }
    } else {
        //        [_entireMenuCategory addCategory:node];
        _entireMenuCategory = node;
    }
}

@end
