//
//  RemoteOrdersDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteOrdersDataProvider.h"
#import "OrdersDataParser.h"

#import "RequestManager.h"
#import "RequestMaker.h"
#import "ParserToJSON.h"


static NSString *const kURLDeleteOrder       = @"http://192.168.195.212/Restaurant/api/Orders/%d";
static NSString *const kURLPostTableOrder    = @"http://192.168.195.212/Restaurant/Api/orders";
static NSString *const kURLGetTableOrders    = @"http://192.168.195.212/Restaurant/api/Orders?tableId=%d";

static const NSUInteger kMaxAttemptsForRequest = 3;

@implementation RemoteOrdersDataProvider


#pragma mark - Load table orders.

// Load orders on one table using tableId.
+ (void)loadTableOrdersWithId:(int)tableId responseBlock:(void (^)(NSArray*, NSError*))callback
{
    
    NSURLRequest *URLRequest = [RequestMaker getRequestWithURL: kURLGetTableOrders
                                                       idOfURL: tableId];
    
    [RequestManager send: URLRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               
               NSArray *arrayOfOrderModel;
               if ( error == nil ) {
                   arrayOfOrderModel = [OrdersDataParser parse: data parsingError: &error];
               }
               // call block from hight layer - DataProvider
               callback(arrayOfOrderModel, error);
           }
         countOfAttempts: kMaxAttemptsForRequest];
}

#pragma mark - HTTP methods.
#pragma mark - DELETE.

// Delete the one order on table using orderId.
+ (void)deleteTableOrderWithOrderId:(int)orderId responseBlock:(void (^)(NSError*))callback
{
    NSURLRequest *urlRequest = [RequestMaker getDeleteRequestWithURL: kURLDeleteOrder
                                                             idOfURL: orderId];
    
    [RequestManager send: urlRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               // call block from hight layer - DataProvider
               callback(error);
           }
         countOfAttempts: kMaxAttemptsForRequest];
}

#pragma mark - POST.

// Post the new order on table using tableId.
+ (void)postTableOrderWithTableModel:(int)table responseBlock:(void (^)(NSUInteger, NSError*))callback
{
    NSNumber *Id = [NSNumber numberWithInt: rand() % 1000];
    NSString *timestamp = [NSString stringWithFormat:@"%@",[NSDate date]] ;
    NSArray *keys    = @[@"Closed",@"TableId", @"Timestamp", @"UserId"];
    NSArray *objects = @[ @"true",[NSNumber numberWithInt: table], timestamp, @"1049" ];
    
    NSData *data = [ParserToJSON createJSONDataWithObjects:objects keys:keys];
    
    
    NSURLRequest *urlRequest = [RequestMaker getRequestWithURL:@"http://192.168.195.212/Restaurant/Orders/NewOrder?tableId=%d" idOfURL:table];
//    NSURLRequest *urlRequest = [RequestMaker getPostRequestWithURL:kURLPostTableOrder idOfURL:0 requestBody: data];
    
    [RequestManager send: urlRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
               // call block from hight layer - DataProvider
               if( error ){
                   callback(-1, error);
               } else {
                   NSString *tmp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                   NSUInteger orderId = [tmp integerValue];
                   callback(orderId, error);
               }
               
           }
         countOfAttempts: kMaxAttemptsForRequest];
}


@end
