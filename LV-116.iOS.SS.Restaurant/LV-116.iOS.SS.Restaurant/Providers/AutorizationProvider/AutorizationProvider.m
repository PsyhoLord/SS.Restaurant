//
//  AutorizationProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "AutorizationProvider.h"

@implementation AutorizationProvider

// load menu data from remote and create menu model with these data
// calls block when model has created
+ (void) logInWithLogin:(NSString*)login password:(NSString*)password block:(void (^)(EnumUserRole, NSError*))callback;
{
    if ( [login isEqualToString:@"123"] && [password isEqualToString:@"123"] ) {
        callback(UserRoleWaiter, nil);
    } else {
        callback(UserRoleClient, nil);
    }
}

+ (void) logOutWithBlock:(void (^)(EnumUserRole, NSError*))callback
{
    callback(UserRoleClient, nil);
}

@end
