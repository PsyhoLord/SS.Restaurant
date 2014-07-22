//
//  AutorizationProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "AuthorizationProvider.h"
#import "RemoteAuthorizationProvider.h"

@implementation AuthorizationProvider

// this method do authorization
// (NSString*)login - login
//(NSString*)password - password
// (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback
// - block which calls for return value: isAuthorizated, userRole, error to hight level
+ (void) logInWithLogin: (NSString*)login
               password: (NSString*)password
          responseBlock: (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback
{
    [RemoteAuthorizationProvider logInWithLogin: login
                                       password: password
                                  responseBlock: ^(BOOL isAuthorizated, UserRole *userRole, NSError *error) {
                                      
                                      // calls block from hight layer
                                      callback(isAuthorizated, userRole, error);
                                      
                                  }];
}

// this method do log out
// (void (^)(UserRole *userRole, NSError *error))callback -
// // - block which calls for return value: userRole, error to hight level
+ (void) logOutWithResponseBlock: (void (^)(UserRole *userRole, NSError *error))callback
{
    [RemoteAuthorizationProvider logOutWithResponseBlock:^(UserRole *userRole, NSError *error) {
        
        // calls block from hight layer
        callback(userRole, error);
        
    }];
    
    
    
}

@end
