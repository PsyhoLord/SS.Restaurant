//
//  UserRole.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "UserRole.h"

// identifier for synchronous queue
static const char *const kSyncQueueIdentifier = "SyncQueueIdentifier";

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
        instance = [[UserRole alloc] init]; // create instance once
    });
    return instance;
}

- (id) init
{
    if ( self = [super init] ) {
        _enumUserRole = UserRoleClient;
        _syncQueue = dispatch_queue_create(kSyncQueueIdentifier, NULL);
    }
    return self;
}

// set enum of current user
- (void) setEnumUserRole: (EnumUserRole)enumUserRole
{
    dispatch_sync(_syncQueue, ^{
        _enumUserRole = enumUserRole;
    });
}

// return current enum of user role
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
    dispatch_sync(_syncQueue, ^{
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
