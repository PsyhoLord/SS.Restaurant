//
//  MenuItem.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuItemModel.h"

@implementation MenuItemModel

- (instancetype)initWithId:(int)Id categoryId:(int) categoryId description:(NSString*)description name:(NSString*)name portions:(int)portions price:(float) price
{
    self = [super init];
    if ( nil != self ) {
        _Id             = Id;
        _categoryId     = categoryId;
        _description    = [[NSString alloc] initWithString:description];
        _name           = [[NSString alloc] initWithString:name];
        _portions       = portions;
        _price          = price;
    }
    return self;
}

- (bool)isImage
{
    return (_image != nil);
}

@end
