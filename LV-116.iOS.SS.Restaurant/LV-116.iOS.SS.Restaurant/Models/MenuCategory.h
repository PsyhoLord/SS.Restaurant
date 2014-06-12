//
//  Category.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface MenuCategory : NSObject

-(instancetype) initWithId:(int)Id name:(NSString*)name parentId:(int)parentId;
-(BOOL) isCategories;
-(BOOL) isItems;

-(void) addCategory:(MenuCategory*)category;
-(void) addItem:(MenuItem*)item;

@property int Id;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSString *name;
@property int parentId;

@end
