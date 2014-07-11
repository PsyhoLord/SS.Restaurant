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

static NSString *const kDeleteOrderURL       = @"http://192.168.195.212/Restaurant/api/Orders/%d";
static NSString *const kLoadTableOrdersURL   = @"http://192.168.195.212/Restaurant/api/Orders?tableId=%d";
static const CGFloat kRequestTimeoutInterval = 3.0;

@implementation RemoteOrdersDataProvider

#pragma mark - Load table orders.

// Load orders on one table using tableId.
+ (void)loadTableOrdersWithId:(int)tableId responseBlock:(void (^)(NSArray*, NSError*))callback
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
// Set request using url with tableId.
+ (NSURLRequest *)getURLRequest:(int)tableId
{
    NSString *urlString = [NSString stringWithFormat: kLoadTableOrdersURL, tableId];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL: URL
                                                cachePolicy: NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval: kRequestTimeoutInterval];
    return URLRequest;
}

#pragma mark - HTTP methods.
#pragma mark - DELETE.

// Delete the one order on table using orderId. 
+ (void)deleteTableOrderWithOrderId:(int)orderId responseBlock:(void (^)(NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteOrdersDataProvider getURLDeleteRequest: orderId];
    
    [RequestManager send: URLRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               // call block from hight layer - DataProvider
               callback(error);
           }
         countOfAttempts: 3];
}
// Set request using url with orderId.
+ (NSURLRequest *)getURLDeleteRequest:(int)orderId
{
    NSString *urlString = [NSString stringWithFormat: kDeleteOrderURL, orderId];
    NSURL *URL = [[NSURL alloc] initWithString: urlString];
    
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL: URL
                                                              cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval: kRequestTimeoutInterval];
    
    [URLRequest setHTTPMethod: @"DELETE" ];
    [URLRequest setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    //    [URLRequest setValue:@"192.168.195.212" forHTTPHeaderField:@"Host"];
    
    return URLRequest;
}

@end
