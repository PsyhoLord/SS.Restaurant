//
//  UserRole.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

typedef enum
{
    UserRoleClient,
    UserRoleWaiter
} EnumUserRole;

@interface UserRole : NSObject

+ (EnumUserRole) LogInWithLogin:(NSString*)login password:(NSString*)password;
+ (EnumUserRole) LogOut;

+ (EnumUserRole) getUserRole;

@end
