//
//  LocalDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/1/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalDataValidator.h"

static EnumDays kDayForUpdateData = Monday;

@implementation LocalDataValidator

// check is need to update local data
+ (BOOL) isNeedForUpdateData
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];

    return ( [comps weekday] == kDayForUpdateData );
}

@end
