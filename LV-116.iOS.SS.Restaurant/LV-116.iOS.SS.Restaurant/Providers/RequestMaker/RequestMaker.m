//
//  RequestMaker.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/13/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RequestMaker.h"

static NSString *const kHTTPMethodDELETE         = @"DELETE";
static NSString *const kHTTPMethodPOST           = @"POST";
static NSString *const kHTTPMethodPUT            = @"PUT";
static NSString *const kHTTPMethodGET            = @"GET";

static NSString *const kHTTPHeaderFieldAccept             = @"Accept";
static NSString *const kHTTPHeaderFieldHost               = @"Host";
static NSString *const kHTTPHeaderFieldContentLength      = @"Content-Length";
static NSString *const kHTTPHeaderFieldContentType        = @"Content-Type";
static NSString *const kHTTPHeaderFieldCookie             = @"Cookie";

static NSString *const kHTTPHeaderValueAccept             = @"application/json";
static NSString *const kHTTPHeaderValueHost               = @"192.168.195.212";

static const CGFloat kRequestTimeoutInterval = 3.0;


@implementation RequestMaker

#pragma mark - GET
// Set GET request using url with id.
+ (NSURLRequest *)getRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"F08237E7D4A2A71D0FC2468AD54E02B491B2E9412F49C17E8372D8C64C3D6AB86678CC05CCB6EACD315EE08507E7C276CA3893DFF4684E7C138C9FEE667AE4FF1B09A956FF36083164217E781FE5DB8E06FA095C54B214F7A4D64772936B5F9F62F51F3B" forKey:@".ASPXAUTH"];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties: cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: cookie];
    
    
    
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                cachePolicy: NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval: kRequestTimeoutInterval];
    [URLRequest setValue:@".ASPXAUTH=969198C425AB97F789BA20B2AEB51E5211A0196AD54F86EAD7911F03B2F3C5AAB84455DC5A563CF443D2AC1247797710C9A7B06F810DE4EB9B73181668B41EEECB89999749A3C2B943FD4F4808B58FCCB1A4BE944FE14FCF52DB48D9BE20A30D312CF63E" forHTTPHeaderField:kHTTPHeaderFieldCookie];
     return URLRequest;
}

#pragma mark - DELETE
// Set DELETE request using url with id.
+ (NSURLRequest *)getDeleteRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id;
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    [URLRequest setValue:@".ASPXAUTH=969198C425AB97F789BA20B2AEB51E5211A0196AD54F86EAD7911F03B2F3C5AAB84455DC5A563CF443D2AC1247797710C9A7B06F810DE4EB9B73181668B41EEECB89999749A3C2B943FD4F4808B58FCCB1A4BE944FE14FCF52DB48D9BE20A30D312CF63E" forHTTPHeaderField:kHTTPHeaderFieldCookie];
    [URLRequest setHTTPMethod: kHTTPMethodDELETE ];
    [URLRequest setValue: kHTTPHeaderValueAccept forHTTPHeaderField: kHTTPHeaderFieldAccept];
    
    return URLRequest;
}

#pragma mark - POST
// Set POST using url with id.
+ (NSURLRequest *)getPostRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
        [URLRequest setValue:@".ASPXAUTH=969198C425AB97F789BA20B2AEB51E5211A0196AD54F86EAD7911F03B2F3C5AAB84455DC5A563CF443D2AC1247797710C9A7B06F810DE4EB9B73181668B41EEECB89999749A3C2B943FD4F4808B58FCCB1A4BE944FE14FCF52DB48D9BE20A30D312CF63E" forHTTPHeaderField:kHTTPHeaderFieldCookie];
    /*    NSArray *objects = @[@"Id", @"Closed", @"tableId", @"timestamp", @"table", @"userId"];
     NSArray *keys = @[@"161", @"false", @"13", @"", @"null", @"1049"];
     NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
     
     NSError *error = nil;
     NSData * JSONData = [NSJSONSerialization dataWithJSONObject: dict
     options: kNilOptions
     error: &error];
     
     [URLRequest setHTTPMethod: @"POST"];
     [URLRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [URLRequest setValue:@"192.168.195.212" forHTTPHeaderField:@"Host"];
     
     [URLRequest setHTTPBody: JSONData]; */
    
    return URLRequest;
}


@end
