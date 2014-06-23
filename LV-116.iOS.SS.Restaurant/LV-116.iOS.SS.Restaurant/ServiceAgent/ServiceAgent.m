//
//  RemoteDataManager.m
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

#import "ServiceAgent.h"

NSString *const connectionErrorNotification = @"connectionErrorNotification";
NSString *const connectionErrorCode         = @"connectionErrorCode";
NSString *const connectionErrorDescription  = @"connectionErrorDescription";

@implementation ServiceAgent {
    // queue for threads
    NSOperationQueue *_operationQueue;
}

-(instancetype)init
{
    if ( self = [super init] ) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
-(void)send:(NSURLRequest *)request responseBlock:(void (^)(NSData*, NSError*))callback
{
    NSLog(@"Function is starting!");
    
    // send request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:_operationQueue
                           completionHandler:[^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if ( connectionError ) {
                                   NSLog(@"Connection error: code:%i description:%@", connectionError.code, connectionError.description);
                                   NSDictionary *userInfo = [[NSDictionary alloc]
                                                             initWithObjectsAndKeys:[NSNumber numberWithInt:connectionError.code ], connectionErrorCode,
                                                             connectionError.description, connectionErrorDescription,
                                                             nil];
                                   // send notification if internet is absent
                                   [[NSNotificationCenter defaultCenter] postNotificationName:connectionErrorNotification object:self userInfo:userInfo];
                               } else {
                                   // call block from hight layer - RemoteDataProvider
                                   callback(data, connectionError);
                               }
                               
                               NSLog(@"NSURLConnection's block've finished!");
                           } copy] ];
    NSLog(@"Function've finished!");
}

@end
