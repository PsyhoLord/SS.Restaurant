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
+ (NSURLRequest*)getRequestWithURL:(NSString*)stringOfURL idOfURL:(int)tableId;

// DELETE
+ (NSURLRequest*)getDeleteRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id;

// PUT
+ (NSURLRequest*)getPutRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id requestBody:(NSData*)body;

// POST
+ (NSURLRequest*)getPostRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id requestBody:(NSData*)body;

// POST Login
+ (NSURLRequest*)getLoginRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id requestBody:(NSData*)data;

@end
