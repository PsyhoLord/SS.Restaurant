//
//  RemoteOrderProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemsDataParser.h"

#import "RemoteOrderProvider.h"

#import "RequestManager.h"
#import "RequestMaker.h"


static NSString *const kURLGetOrderItems            = @"http://192.168.195.212/Restaurant/api/Orders/?id=%d";
static NSString *const kURLPutToUpdateOrderItems    = @"http://192.168.195.212/Restaurant/api/Orders/";
static NSString *const kURLPutCloseOrder            = @"http://192.168.195.212/Restaurant/api/Orders/id=%d";



@implementation RemoteOrderProvider


//loads orderItems using orderId
+ (void) loadOrderItemsWithId:(int)orderId responseBlock:(void (^)(NSArray*, NSError*))callback
{
    NSURLRequest *urlRequest = [RequestMaker getRequestWithURL: kURLGetOrderItems
                                                       idOfURL: orderId];
    [RequestManager send: urlRequest
           responseBlock: ^(NSHTTPURLResponse *response, NSData *data, NSError *error){
               NSArray *orderItemsModel;
               if ( error == nil ) {
                   orderItemsModel = [OrderItemsDataParser parse: data parsingError: &error];
               }
               //if there is errors returns nil
               callback (orderItemsModel, error);
           }
     ];
}

// Updates Order by sending data
+ (void) sendDataFromOrderToUpdate: (NSData * )data responseBlock: (void (^)(NSError*)) callback
{
    NSURLRequest * urlRequest = [RequestMaker putRequestWithURL: kURLPutToUpdateOrderItems
                                                           idOfURL: 0
                                                       requestBody: data
                                 ];
    [RequestManager send: urlRequest
           responseBlock:^(NSHTTPURLResponse * response, NSData *responseData, NSError *error) {
               callback (error);
           }
     
     ];
}

//Closing Order by specifed ID
+ (void) closeOrderById: (int)orderId responseBlock: (void (^)(NSError*)) callback
{
    NSURLRequest *urlRequest = [RequestMaker putRequestWithURL: kURLPutCloseOrder
                                                          idOfURL: orderId
                                                      requestBody: nil
                                ];

    [RequestManager send:urlRequest
           responseBlock:^(NSHTTPURLResponse *response, NSData *data , NSError *error){
               callback (error);
           }
     
     ];
}


@end
