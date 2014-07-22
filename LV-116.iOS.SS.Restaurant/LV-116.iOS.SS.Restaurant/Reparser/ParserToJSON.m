//
//  ParserToJSON.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ParserToJSON.h"
#import "UserRole.h"


static NSString *const kKeyUserName         = @"UserName";
static NSString *const kKeyPassword         = @"Password";
static NSString *const kKeyRememberMe       = @"RememberMe";

static NSString *const kKeyClosed       =  @"Closed";
static NSString *const kKeyItems       =  @"Items";
static NSString *const kKeyTableId       =  @"TableId";
static NSString *const kKeyTimestamp       =  @"Timestamp";
static NSString *const kKeyUserId       =  @"UserId";



@implementation ParserToJSON

// Return JSON data which are based on arays.
+(NSData*)createJSONDataWithObjects:(NSArray*)objects keys:(NSArray*)keys
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects: objects
                                                                     forKeys: keys];
    NSError *error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject: dict
                                                        options: NSJSONWritingPrettyPrinted
                                                          error: &error];
    if( error != nil ) {
        return nil;
    } else {
        return jsonData;
    }
}

// Returns JSON data using dictionary.
+(NSData*)createJSONDataWithDictionary:(NSDictionary*)jsonDictionary
{
    NSError *error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject: jsonDictionary
                                                        options: NSJSONWritingPrettyPrinted
                                                          error: &error];
    if( error != nil ) {
        return nil;
    } else {
        return jsonData;
    }
}

+(NSData*)createJSONDataForNewOrderWithTableId:(int)tableId
{
    NSNumber *tableIdNumber = [NSNumber numberWithInt: tableId];
      long long int timeInMiliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timestamp = [[NSString alloc] initWithFormat:@"/Date(%lld+0200)/", timeInMiliseconds];
//    NSNumber *userIdNumber = [NSNumber numberWithInt: ([UserRole getInstance]).userId ];
    NSNumber *userIdNumber = @1049;
    
    NSArray  *keys    = @[ kKeyClosed, kKeyItems, kKeyTableId, kKeyTimestamp, kKeyUserId ];
    NSArray  *objects = @[ @NO, @[], tableIdNumber, timestamp, userIdNumber ];
    
    NSData *data = [ParserToJSON createJSONDataWithObjects:objects keys:keys];
    
    return data;
}

+(NSData*)createJSONDataForAuthorizationWithLogin:(NSString*)userName password:(NSString*)password rememberMe:(BOOL)rememberMe
{
    NSString *boolRememberMe = rememberMe ? @"true" : @"false";
    // Arrays are created for getting JSON data.
    NSArray *keys       = @[ kKeyUserName, kKeyPassword, kKeyRememberMe ];
    NSArray *objects    = @[ userName, password, boolRememberMe ];   //BOOL!!!
    
    NSData *jsonData = [ParserToJSON createJSONDataWithObjects: objects
                                                          keys: keys];
    
    return jsonData;
}

// Return dictionary. We can use it for create JSON data.
+(NSDictionary*)createJSONStringsWithObjects:(NSArray*)objects keys:(NSArray*)keys
{
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] initWithObjects: objects
                                                                               forKeys: keys];
    return jsonDictionary;
}



@end
