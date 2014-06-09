//
//  MenuRemoteDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteDataProvider.h"
#import "PServiceAgent.h"
#import "ServiceAgent.h"
#import "MenuDataParser.h"

@implementation RemoteDataProvider
{
    id<PServiceAgent> _serviceAgent;
}

-(instancetype)init
{
    if ( self = [super init] ) {
        _serviceAgent = [[ServiceAgent alloc] init];
    }
    return self;
}

-(NSArray*)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback
{
    NSString *strRequest = [[NSString alloc] initWithFormat:@"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i", Id];
    
    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
    
    __block NSMutableArray *arrCategories;

    [_serviceAgent send:URLRequest
          responseBlock:^(NSData *data, NSError *error) {

              // call parser
              arrCategories = [MenuDataParser parse:data];
              callback(arrCategories, error);
              
          }];
    return arrCategories;
}

@end
