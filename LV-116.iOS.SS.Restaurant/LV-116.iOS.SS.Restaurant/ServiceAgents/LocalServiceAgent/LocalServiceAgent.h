//
//  LocalServiceAgent.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@interface LocalServiceAgent : NSObject

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error;

+ (NSUInteger) countForFetchRequest: (NSFetchRequest *)request error: (NSError **)error;

+ (BOOL)save:(NSError **)error;

@end
