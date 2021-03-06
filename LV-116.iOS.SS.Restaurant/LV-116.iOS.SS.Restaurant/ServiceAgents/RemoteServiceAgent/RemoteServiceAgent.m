//
//  RemoteDataManager.m
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

#import "RemoteServiceAgent.h"

@implementation RemoteServiceAgent

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
+ (void) send: (NSURLRequest *)request responseBlock: (void (^)(NSHTTPURLResponse*, NSData*, NSError*))callback
{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    // send request
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: operationQueue
                           completionHandler: ^(NSURLResponse *urlResponse, NSData *data, NSError *connectionError) {
                               // call block from hight layer - RemoteDataProvider
                               callback((NSHTTPURLResponse*)urlResponse, data, connectionError);
                           }
     ];
    
}

@end
