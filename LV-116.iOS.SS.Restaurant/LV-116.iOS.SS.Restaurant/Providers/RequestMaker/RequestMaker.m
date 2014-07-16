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

static NSString *const kHTTPHeaderValueAcceptAppJSON      = @"application/json";
static NSString *const kHTTPHeaderValueHost               = @"192.168.195.212";

static const CGFloat kRequestTimeoutInterval = 3.0;


@implementation RequestMaker

#pragma mark - GET
// Set GET request using url with id.
+ (NSURLRequest *)getRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id
{
  /*  NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    
    [cookieProperties setObject:@".ASPXAUTH" forKey: NSHTTPCookieName];
    [cookieProperties setObject:@"969198C425AB97F789BA20B2AEB51E5211A0196AD54F86EAD7911F03B2F3C5AAB84455DC5A563CF443D2AC1247797710C9A7B06F810DE4EB9B73181668B41EEECB89999749A3C2B943FD4F4808B58FCCB1A4BE944FE14FCF52DB48D9BE20A30D312CF63E" forKey: NSHTTPCookieValue];
    [cookieProperties setObject:@"http://192.168.195.212/Restaurant/Security/Authenticate" forKey: NSHTTPCookieOriginURL];
    [cookieProperties setObject: @"/" forKey: NSHTTPCookiePath];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties: cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: cookie];
    NSLog(@"ncookie: %@", cookie);*/
    
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                cachePolicy: NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval: kRequestTimeoutInterval];
//    [URLRequest setAllHTTPHeaderFields: headers];
    
   /* [URLRequest setValue:@".ASPXAUTH=969198C425AB97F789BA20B2AEB51E5211A0196AD54F86EAD7911F03B2F3C5AAB84455DC5A563CF443D2AC1247797710C9A7B06F810DE4EB9B73181668B41EEECB89999749A3C2B943FD4F4808B58FCCB1A4BE944FE14FCF52DB48D9BE20A30D312CF63E" forHTTPHeaderField:kHTTPHeaderFieldCookie];*/
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
    [URLRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];
    
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


    
    return URLRequest;
}

// Return request that can used for login.
+ (NSURLRequest *)getLoginRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id data:(NSData*)data
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    // Set HTTP header.
    [URLRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];
    [URLRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldContentType];
    
    // Set POST method and JSON data.
    [URLRequest setHTTPMethod: kHTTPMethodPOST];
    [URLRequest setHTTPBody: data];
    
    return URLRequest;
}



@end
