//
//  MenuItem.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class MenuItem is needed for contains data of item

@interface MenuItemModel : NSObject

- (instancetype)initWithId:(int)Id categoryId:(int) categoryId description:(NSString*)description name:(NSString*)name portions:(int)portions price:(float) price;

- (bool)isImage;

@property (assign, nonatomic) int Id;
@property (assign, nonatomic) int categoryId;
@property (assign, nonatomic) int portions;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;

@end
