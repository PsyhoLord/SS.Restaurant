//
//  RequestManager.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class RequestManager needs for retrying to send request if it is some connection error

@interface RequestManager : NSObject

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
// ountOfAttempts:(int)countOfAttempts - count of attempts if it is no internet
+ (void)send:(NSURLRequest *)urlRequest responseBlock:(void (^)(NSData*, NSError*))callback countOfAttempts:(int)countOfAttempts;

@end
