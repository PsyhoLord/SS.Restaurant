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
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL: URL
                                                cachePolicy: NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval: kRequestTimeoutInterval];
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
