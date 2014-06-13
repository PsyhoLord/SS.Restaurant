//
//  RemoteDataManager.m
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

#import "ServiceAgent.h"

@implementation ServiceAgent {
    NSOperationQueue *_operationQueue;
}

-(instancetype)init
{
    if ( self = [super init] ) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void)send:(NSURLRequest *)request responseBlock:(void (^)(NSData*, NSError*))callback
{
    NSLog(@"Function is starting!");
    
    //    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    // send request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:_operationQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               // get response
                               callback(data, connectionError);
                               
                               NSLog(@"NSURLConnection's block've finished!");
                           }];
    NSLog(@"Function've finished!");
}

@end
