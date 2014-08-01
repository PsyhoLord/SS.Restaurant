//
//  LocalDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/1/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MapModel;

typedef enum
{
    Sunday = 1,
    Monday,
    Tuesady,
    Wednesday,
    Thursday,
    Friday,
    Saturday
} EnumDays;

@interface LocalDataValidator : NSObject

// check is need to update local data
+ (BOOL) isNeedForUpdateData;

@end
