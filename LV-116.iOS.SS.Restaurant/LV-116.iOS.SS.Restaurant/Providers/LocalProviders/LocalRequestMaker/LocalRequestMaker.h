//
//  LocalRequestMaker.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@interface LocalRequestMaker : NSObject

+ (NSFetchRequest*) fetchRequestWithEntity:(NSString*)entity;

@end
