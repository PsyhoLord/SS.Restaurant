//
//  UserRole.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "UserRole.h"

@implementation UserRole
{
    dispatch_queue_t _syncQueue;
}

@synthesize enumUserRole    = _enumUserRole;
@synthesize name            = _name;

+ (instancetype) getInstance
{
    static UserRole *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserRole alloc] init];
    });
    return instance;
}

- (id) init
{
    if ( self = [super init] ) {
        _enumUserRole = UserRoleClient;
        _syncQueue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

- (void) setEnumUserRole: (EnumUserRole)enumUserRole
{
    dispatch_barrier_async(_syncQueue, ^{
        _enumUserRole = enumUserRole;
    });
}

- (EnumUserRole) enumUserRole
{
    __block EnumUserRole enumUserRole;
    dispatch_sync(_syncQueue, ^{
        enumUserRole = _enumUserRole;
    });
    return enumUserRole;
}

- (void) setName: (NSString *)name
{
    dispatch_barrier_async(_syncQueue, ^{
        _name = name;
    });
}

- (NSString*) name
{
    __block NSString *name;
    dispatch_sync(_syncQueue, ^{
        name = _name;
    });
    return name;
}

@end
