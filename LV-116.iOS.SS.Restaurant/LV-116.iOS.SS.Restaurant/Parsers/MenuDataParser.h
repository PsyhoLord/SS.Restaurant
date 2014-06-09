//
//  MenuDataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataParser.h"
#define ID          @"Id"
#define Name        @"Name"
#define ParentId    @"ParentId"
#define Portions    @"Portions"
#define Price       @"Price"
#define CategoryId  @"CategoryId"
#define Description @"Description"
#define Items       @"Items"
#define IsActive    @"IsActive"

@interface MenuDataParser : NSObject<DataParser>

@end
