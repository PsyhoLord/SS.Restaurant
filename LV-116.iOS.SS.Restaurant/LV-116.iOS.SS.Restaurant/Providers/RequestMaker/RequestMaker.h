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
+ (NSURLRequest *)getRequestWithURL:(NSString*)stringOfURL idOfURL:(int)tableId;

// DELETE
+ (NSURLRequest *)getDeleteRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id;

// POST
+ (NSURLRequest *)getPostRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id;

// POST Login
+ (NSURLRequest *)getLoginRequestWithURL:(NSString*)stringOfURL idOfURL:(int)Id data:(NSData*)data;

@end
