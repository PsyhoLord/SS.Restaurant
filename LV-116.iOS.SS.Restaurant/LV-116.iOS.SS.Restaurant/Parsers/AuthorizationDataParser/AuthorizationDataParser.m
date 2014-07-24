//
//  AuthorizationDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "AuthorizationDataParser.h"

#import "UserRole.h"

static NSString *const kJSONKeyUser        = @"User";
static NSString *const kJSONKeyWaiter      = @"Waiter";
static NSString *const kJSONKeyRoles       = @"Roles";
static NSString *const kJSONKeyName        = @"Name";
static NSString *const kJSONKeyPhoneNumber = @"PhoneNumber";
static NSString *const kJSONKeyPhoneImage  = @"Image";


@implementation AuthorizationDataParser

+ (id)parse:(NSData*) data parsingError:(NSError**) parseError
{
    NSError *parsingError = nil;
    
    // Calling a method, which will be convert data from JSON to OrderModel.
    NSMutableDictionary *authorizationDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                                   options: NSJSONReadingMutableContainers
                                                                                     error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    
    [self parseRole: authorizationDictionary];
    return authorizationDictionary;
}

// Sets user settings for singleton.
+(void)parseRole:(NSDictionary*)authorizationDictionary
{
    NSMutableDictionary *userInfo = [authorizationDictionary objectForKey: kJSONKeyUser];
    NSArray *str = [authorizationDictionary objectForKey:kJSONKeyRoles];
    
    
    if( [str[0] isEqualToString: kJSONKeyWaiter]  ) {
        [UserRole getInstance].enumUserRole = UserRoleWaiter;
    }
    
    [UserRole getInstance].name = [userInfo valueForKey: kJSONKeyName];
    [UserRole getInstance].phoneNumber = [userInfo valueForKey: kJSONKeyPhoneNumber];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[userInfo objectForKey: kJSONKeyPhoneImage] ];
    [UserRole getInstance].photo = [[UIImage alloc] initWithData:data];
}


@end
