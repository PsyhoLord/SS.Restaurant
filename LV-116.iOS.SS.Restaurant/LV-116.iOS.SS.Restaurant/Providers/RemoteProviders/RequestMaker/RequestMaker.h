//
//  RequestMaker.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/13/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestMaker : NSObject

// GET
+ (NSURLRequest*)getRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)tableId;

// DELETE
+ (NSURLRequest*)getDeleteRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// PUT
+ (NSURLRequest*)getPutRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// POST
+ (NSURLRequest*)getPostRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// POST Login
+ (NSURLRequest*)getLoginRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

@end
