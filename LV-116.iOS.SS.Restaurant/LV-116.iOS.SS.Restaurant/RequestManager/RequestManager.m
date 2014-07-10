//
//  RequestManager.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RequestManager.h"
#import "ServiceAgent.h"

@implementation RequestManager

// send request to server and call block when response comes
// (NSURLRequest *)request - request
// responseBlock:(void (^)(NSData*, NSError*))callback - block which will call when response come
// countOfAttempts:(int)countOfAttempts - count of attempts if it is no internet
+ (void) send: (NSURLRequest *)urlRequest responseBlock: (void (^)(NSHTTPURLResponse*, NSData*, NSError*))callback countOfAttempts: (int)countOfAttempts
{
    --countOfAttempts;
    [ServiceAgent send: urlRequest responseBlock: ^(NSHTTPURLResponse *urlResponse, NSData *data, NSError *error) {
        
        if ( error && countOfAttempts ) {
            [RequestManager send: urlRequest responseBlock: callback countOfAttempts: countOfAttempts];
        } else {
            callback(urlResponse, data, error);
        }
        
    } ];
}

@end
