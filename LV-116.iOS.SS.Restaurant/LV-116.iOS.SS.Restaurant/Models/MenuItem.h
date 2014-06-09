//
//  MenuItem.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

-(instancetype)initWithId:(int)Id categoryId:(int) categoryId description:(NSString*)description name:(NSString*)name portions:(int)portions price:(float) price;

@property int Id;
@property int categoryId;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *name;
@property int portions;
@property float price;

@end
