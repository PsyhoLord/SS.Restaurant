//
//  LocalServiceAgent.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@interface LocalServiceAgent : NSObject

+ (NSArray *) executeFetchRequestForEntity: (NSString *)entityName error: (NSError **)error;

+ (NSUInteger) countForFetchRequestForEntity: (NSString *)entityName error: (NSError **)error;

+ (id) insertNewObjectForEntityName: (NSString *)entityName;

+ (BOOL) save: (NSError **)error;

+ (void) deleteDataFromEntity: (NSString*)entityName;

+ (BOOL) isDataInEntity: (NSString*)entityName;

@end
