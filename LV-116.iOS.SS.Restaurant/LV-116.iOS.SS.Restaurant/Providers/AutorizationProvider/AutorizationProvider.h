//
//  AutorizationProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "UserRole.h"

@interface AutorizationProvider : NSObject

+ (void) logInWithLogin:(NSString*)login password:(NSString*)password block:(void (^)(EnumUserRole, NSError*))callback;

+ (void) logOutWithBlock:(void (^)(EnumUserRole, NSError*))callback;

@end
