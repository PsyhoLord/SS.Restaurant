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
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               // call block from hight layer - RemoteDataProvider
                               callback(data, connectionError);

                           } ];
    
}

@end
