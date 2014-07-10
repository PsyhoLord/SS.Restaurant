//
//  PDataManager.h
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

@protocol PServiceAgent <NSObject>

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
+ (void) send: (NSURLRequest *)request responseBlock: (void (^)(NSHTTPURLResponse*, NSData*, NSError*))callback;

@end
