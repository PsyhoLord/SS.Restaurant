//
//  RequestMaker.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/13/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RequestMaker.h"

static NSString *const kHTTPMethodDELETE             = @"DELETE";
static NSString *const kHTTPMethodPOST               = @"POST";
static NSString *const kHTTPMethodPUT                = @"PUT";
static NSString *const kHTTPMethodGET                = @"GET";

static NSString *const kHTTPHeaderFieldAccept        = @"Accept";
static NSString *const kHTTPHeaderFieldHost          = @"Host";
static NSString *const kHTTPHeaderFieldContentLength = @"Content-Length";
static NSString *const kHTTPHeaderFieldContentType   = @"Content-Type";
static NSString *const kHTTPHeaderFieldCookie        = @"Cookie";

static NSString *const kHTTPHeaderValueAcceptAppJSON = @"application/json";
static NSString *const kHTTPHeaderValueHost          = @"192.168.195.212";

static const CGFloat kRequestTimeoutInterval = 10.0;


@implementation RequestMaker

#pragma mark - GET
// Set GET request using url with id.
+ (NSURLRequest*)getRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    NSURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url
                                                cachePolicy: NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval: kRequestTimeoutInterval];

     return urlRequest;
}

#pragma mark - DELETE
// Set DELETE request using url with id.
+ (NSURLRequest*)getDeleteRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];

    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];

    urlRequest.HTTPMethod = kHTTPMethodDELETE;
    urlRequest.HTTPBody   = bodyData;
    
    return urlRequest;
}

#pragma mark - PUT
// Set PUT using url with id and http body.
+ (NSURLRequest*)getPutRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldContentType];
    
    urlRequest.HTTPMethod = kHTTPMethodPUT;
    urlRequest.HTTPBody   = bodyData;
    
    return urlRequest;
}


#pragma mark - POST
// Set POST using url with id of url and http body.
+ (NSURLRequest*)getPostRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldContentType];

    urlRequest.HTTPMethod = kHTTPMethodPOST;
    urlRequest.HTTPBody   = bodyData;
    
    return urlRequest;
}

#pragma mark - POST login
// Return request that can used for login.
+ (NSURLRequest*)getLoginRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData
{
    NSString *urlString = [NSString stringWithFormat: stringOfURL, Id];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    // Set HTTP header.
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldAccept];
    [urlRequest setValue: kHTTPHeaderValueAcceptAppJSON forHTTPHeaderField: kHTTPHeaderFieldContentType];
    
    // Set POST method and JSON data.
    urlRequest.HTTPMethod = kHTTPMethodPOST;
    urlRequest.HTTPBody   = bodyData;
    
    return urlRequest;
}



@end
