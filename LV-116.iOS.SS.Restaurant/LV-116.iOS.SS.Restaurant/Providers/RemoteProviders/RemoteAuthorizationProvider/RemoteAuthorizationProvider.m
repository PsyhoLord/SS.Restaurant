//
//  RemoteAuthorizationProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/10/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteAuthorizationProvider.h"

#import "RequestMaker.h"
#import "RequestManager.h"

#import "AuthorizationDataParser.h"
#import "ParserToJSON.h"
#import "UserRole.h"

static NSString *const kURLAuthenticate     = @"http://192.168.195.212/Restaurant/Security/Authenticate";
static NSString *const kCookieASPXAUTH      = @".ASPXAUTH";
static NSString *const kCookiePath          = @"/";

static NSString *const kHTTPHeaderSetCookie = @"Set-Cookie";

static NSString *const kJSONKeyIsSuccess    = @"isSuccess";


@implementation RemoteAuthorizationProvider


#pragma mark - Login.
// this method do authorization
// (NSString*)login - login
//(NSString*)password - password
// (void (^)(BOOL isAuthorizated, UserRole *userRole, NSError *error))callback
// - block which calls for return value: isAuthorizated, userRole, error to hight level
+ (void) logInWithLogin: (NSString*)login password: (NSString*)password responseBlock: (void (^)(BOOL isAuthorizated, UserRole*, NSError*))callback
{
    NSData *jsonData = [ParserToJSON createJSONDataForAuthorizationWithLogin: login
                                                                    password: password
                                                                  rememberMe: true];
    // Creates request using JSON data.
    NSURLRequest *urlRequest = [RequestMaker getLoginRequestWithURL: kURLAuthenticate
                                                            idOfURL: 0
                                                        requestBody: jsonData ];
    [RequestManager send: urlRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               
               if ( error == nil ) {
                   // If login data are true then response is JSON ( { isSuccess : "true" } ).
                   
                   
                   NSMutableDictionary *authorizationResponse = [AuthorizationDataParser parse: data parsingError: &error];
                   
                   NSString *isSuccess = [authorizationResponse valueForKeyPath: kJSONKeyIsSuccess];
                   
                   if( [response statusCode] == 200 && [isSuccess boolValue] ) {
                       
                       [UserRole getInstance].enumUserRole = UserRoleWaiter;
                       // Adds cookies into singleton
                       [RemoteAuthorizationProvider createCookieStorageWithHeaderSetCookie:response];
                       
                       callback(YES, [UserRole getInstance], error);
                   }
                   else {
                       callback(NO, nil, error);
                   }
               }
           }
     ];
}

// This method creates cookie storage in our application.
+(void)createCookieStorageWithHeaderSetCookie:(NSHTTPURLResponse*)response
{
    // Gets string of header "Set-Cookie".
    NSDictionary *headerDictionary = [response allHeaderFields];
    NSString *headerSetCookie = [headerDictionary valueForKey: kHTTPHeaderSetCookie];
    
    // Gets token from headerSetCookie.
    NSString *token = [RemoteAuthorizationProvider getToken:headerSetCookie];
    
    NSMutableDictionary *cookieProperties = [[NSMutableDictionary alloc] init];
    
    // Cookie name
    [cookieProperties setObject: kCookieASPXAUTH forKey: NSHTTPCookieName];
    // Cookie value
    [cookieProperties setObject: token forKey: NSHTTPCookieValue];
    // Cookie url
    [cookieProperties setObject: kURLAuthenticate forKey: NSHTTPCookieOriginURL];
    // Cookie path
    [cookieProperties setObject: kCookiePath forKey: NSHTTPCookiePath];
    
    // Cookies init from dictionary and then save into cookie storage.
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties: cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: cookie];
    
}

// Returns ASPX token.
+(NSString*)getToken:(NSString*)headerSetCookie
{
    // Separates header "Set-Cookie" apart.
    NSArray *arrayOfSetCookie = [headerSetCookie componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString: @";,"]];
    NSString *token = nil;
    
    for ( NSString *cookie in arrayOfSetCookie ) {
        if ( [cookie hasPrefix: kCookieASPXAUTH] ) {
            // We need only token (not key). Therefore we ignore .ASPXAUTH .
            NSRange range =  [cookie rangeOfString: kCookieASPXAUTH];
            token = [cookie substringFromIndex: range.length+1 ]; // +1 because kCookieASPXAUTH hasn't =
            return token;
        }
    }
    
    return token;
}

#pragma mark - Logout

// this method do log out
// (void (^)(UserRole *userRole, NSError *error))callback -
// // - block which calls for return value: userRole, error to hight level
+ (void) logOutWithResponseBlock: (void (^)(UserRole*, NSError*))callback
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    [UserRole getInstance].enumUserRole = UserRoleClient;
    callback([UserRole getInstance], nil);
}

@end
