//
//  RemoteAuthorizationProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/10/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteAuthorizationProvider.h"
#import "UserRole.h"

@implementation RemoteAuthorizationProvider

// this method do authorization
// (NSString*)login - login
//(NSString*)password - password
// (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback
// - block which calls for return value: isAuthorizated, userRole, error to hight level
+ (void) logInWithLogin: (NSString*)login
               password: (NSString*)password
          responseBlock: (void (^)(BOOL isAuthorizated, UserRole*, NSError*))callback
{
    // this is only for test
    if ( [login isEqualToString:@"123"] && [password isEqualToString:@"123"] ) {
        [UserRole getInstance].enumUserRole = UserRoleWaiter;
        callback(YES, [UserRole getInstance], nil);
    } else {
        callback(NO, nil, nil);
    }
}

// this method do log out
// (void (^)(UserRole *userRole, NSError *error))callback -
// // - block which calls for return value: userRole, error to hight level
+ (void) logOutWithResponseBlock: (void (^)(UserRole*, NSError*))callback
{
    // this is only for test
    callback([UserRole getInstance], nil);
}

@end
