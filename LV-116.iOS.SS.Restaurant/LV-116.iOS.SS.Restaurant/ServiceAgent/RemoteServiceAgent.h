//
//  ServiceAgent.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class ServiceAgent sends request and get response from server

@interface RemoteServiceAgent : NSObject

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
+ (void) send: (NSURLRequest *)request responseBlock: (void (^)(NSHTTPURLResponse*, NSData*, NSError*))callback;

@end
