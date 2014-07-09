//
//  UserRole.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "UserRole.h"

static EnumUserRole _userRole   = UserRoleClient;

@implementation UserRole

+ (void) setUserRole: (EnumUserRole)userRole
{
    _userRole = userRole;
}

+ (EnumUserRole) getUserRole
{
    return _userRole;
}

@end
