//
//  MenuItem.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

// class MenuItem is needed for contains data of item

@interface MenuItem : NSObject

-(instancetype)initWithId:(int)Id categoryId:(int) categoryId description:(NSString*)description name:(NSString*)name portions:(int)portions price:(float) price;

@property long Id;
@property long categoryId;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *name;
@property long portions;
@property float price;

@end
