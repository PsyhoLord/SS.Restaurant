//
//  RemoteOrdersDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteOrdersDataProvider.h"
#import "RequestManager.h"
#import "OrdersDataParser.h"

@implementation RemoteOrdersDataProvider

// Load orders on one table using tableId.
+ (void)loadTableOrdersWithId:(int)tableId withBlock:(void (^)(NSArray*, NSError*))callback
{
    
    NSURLRequest *URLRequest = [RemoteOrdersDataProvider getURLRequest:tableId];
    
    [RequestManager send: URLRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               
               NSArray *arrayOfOrderModel;
               if ( error == nil ) {
                   arrayOfOrderModel = [OrdersDataParser parse: data parsingError: &error];
               }
               // call block from hight layer - DataProvider
               callback(arrayOfOrderModel, error);
               
           }
         countOfAttempts: 3];
}
// Set request using url.
+ (NSURLRequest *)getURLRequest:(int)tableId
{
    NSString *urlString = [NSString stringWithFormat: @"http://192.168.195.212/Restaurant/api/Orders?tableId=%d", tableId];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL: URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    return URLRequest;
}

@end
