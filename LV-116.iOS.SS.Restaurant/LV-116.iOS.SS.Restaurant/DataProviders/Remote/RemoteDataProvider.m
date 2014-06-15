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


// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
-(void)getEntireMenuDataWithResponseBlock:(void (^)(MenuModel*, NSError*))callback
{
    int Id = 0;
    
    NSString *strRequest = [[NSString alloc] initWithFormat:URLMenu, Id];
    
    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
    
    [_serviceAgent send:URLRequest
          responseBlock:^(NSData *data, NSError *error) {
              
              // call parser
              MenuModel *entireMenuModel = [MenuDataParser parseEntireMenu:data];
              // call block from hight layer - DataProvider
              callback(entireMenuModel, error);
              
          }];
}

// get menu data from server
// (int)Id - id of category which we need to get data from it
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
-(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback
{
    NSString *strRequest = [[NSString alloc] initWithFormat:URLMenu, Id];
    
    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
    
    __block NSMutableArray *arrCategories;
    
    [_serviceAgent send:URLRequest
          responseBlock:^(NSData *data, NSError *error) {
              
              // call parser
              arrCategories = [MenuDataParser parseCurrentCategory:data];
              // call block from hight layer - DataProvider
              callback(arrCategories, error);
              
          }];
}

@end
