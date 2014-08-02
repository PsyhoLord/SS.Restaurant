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
+ (NSURLRequest*)deleteRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// PUT
+ (NSURLRequest*)putRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// POST
+ (NSURLRequest*)postRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

// POST Login
+ (NSURLRequest*)loginRequestWithURL:(NSString*)stringOfURL idOfURL:(NSUInteger)Id requestBody:(NSData*)bodyData;

@end
