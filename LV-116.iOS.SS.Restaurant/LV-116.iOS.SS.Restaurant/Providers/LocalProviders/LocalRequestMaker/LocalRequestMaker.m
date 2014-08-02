//
//  LocalRequestMaker.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalRequestMaker.h"

@implementation LocalRequestMaker

+ (NSFetchRequest*) fetchRequestWithEntity: (NSString*)entity
{
    return [[NSFetchRequest alloc] initWithEntityName: entity];
}

@end
