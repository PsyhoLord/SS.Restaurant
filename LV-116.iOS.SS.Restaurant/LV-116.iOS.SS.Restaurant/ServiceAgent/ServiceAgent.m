//
//  RemoteDataManager.m
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

#import "ServiceAgent.h"

@implementation ServiceAgent

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
+ (void)send:(NSURLRequest *)request responseBlock:(void (^)(NSData*, NSError*))callback
{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    // send request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:operationQueue
                           completionHandler:[^(NSURLResponse *response, NSData *data, NSError *connectionError) {
#warning What do you need the notification for ? I can easily pass an error in callback below and handle it later !!!
                                   // call block from hight layer - RemoteDataProvider
#warning It should be enough to send the error in callback and then handle it in view controller (just to complement previous statement :) )
        callback(data, connectionError);
        
        NSLog(@"NSURLConnection's block've finished!");
    } copy] ];
#warning What is a purpose of using copy method here ? Why do you need to copy the block ? Please, be ready to explain
    
}

@end
