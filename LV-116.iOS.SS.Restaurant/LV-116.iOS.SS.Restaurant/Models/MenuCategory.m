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
// Test comment
-(BOOL) isCategories
{
    return ( 0 != [self.categories count] );
//    return ( nil != _categories );
}

-(BOOL) isItems
{
    return ( 0 != [self.items count] );
//    return ( nil != _items );
}

-(void) addCategory:(MenuCategory*)category
{
    if ( nil == self.categories ) {
        self.categories = [[NSMutableArray alloc] init];
    }
    [self.categories addObject:category];
}

-(void) addItem:(MenuItem*)item
{
    if ( nil == self.items ) {
        self.items = [[NSMutableArray alloc] init];
    }
    [self.items addObject:item];
}

@end
