//
//  AutorizationProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class AuthorizationProvider need for
// call remote for authorization or log out

@class UserRole;

@interface AuthorizationProvider : NSObject

// this method do authorization
// (NSString*)login - login
//(NSString*)password - password
// (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback
// - block which calls for return value: isAuthorizated, userRole, error to hight level
+ (void) logInWithLogin: (NSString*)login
               password: (NSString*)password
          responseBlock: (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback;

// this method do log out
// (void (^)(UserRole *userRole, NSError *error))callback -
// // - block which calls for return value: userRole, error to hight level
+ (void) logOutWithResponseBlock: (void (^)(UserRole *userRole, NSError *error))callback;

@end
