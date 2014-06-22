//
//  Category.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuCategory.h"

@implementation MenuCategory

-(instancetype) initWithId:(int)Id name:(NSString*)name parentId:(int)parentId
{
    self = [super init];
    if ( nil != self ) {
        self.Id         = Id;
        self.name       = [[NSString alloc] initWithString:name];
        self.parentId   = parentId;
    }
    return self;
}

-(BOOL) isCategories
{
    return ( [self.categories count] != 0 );
}

-(BOOL) isItems
{
    return ( [self.items count] != 0 );
}

-(void) addCategory:(MenuCategory*)category
{
    if ( self.categories == nil ) {
        self.categories = [[NSMutableArray alloc] init];
    }
    [self.categories addObject:category];
}

-(void) addItem:(MenuItem*)item
{
    if ( self.items == nil ) {
        self.items = [[NSMutableArray alloc] init];
    }
    [self.items addObject:item];
}

@end
