//
//  MenuItem.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(instancetype)initWithId:(int)Id categoryId:(int) categoryId description:(NSString*)description name:(NSString*)name portions:(int)portions price:(float) price
{
    self = [super init];
    if ( nil != self ) {
        self.Id             = Id;
        //        self.image          = [UIImage alloc] init
        self.categoryId     = categoryId;
        self.description    = [[NSString alloc] initWithString:description];
        self.name           = [[NSString alloc] initWithString:name];
        self.portions       = portions;
        self.price          = price;
    }
    return self;
}

-(bool)isImage
{
    return (self.image != nil);
}

@end
