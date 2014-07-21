//
//  UserRole.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class UserRole contains current state of user
// This class is Singleton

// Enum of current user
typedef enum
{
    UserRoleClient,
    UserRoleWaiter
} EnumUserRole;

@interface UserRole : NSObject

// return instance of UserRole
+ (instancetype) getInstance;

@property EnumUserRole enumUserRole;    // return enum of current user
@property (nonatomic) int userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *cookie;

@end
