//
//  MenuRemoteDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteDataProvider.h"
#import "PServiceAgent.h"
#import "MenuModel.h"
#import "MapModel.h"
#import "MenuDataParser.h"
#import "MapDataParser.h"

NSString *const URLMenu             = @"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i";
NSString *const URLDownloadImage    = @"http://192.168.195.212/Restaurant/Menu/ImageResult/%i";
const int connectionTimeoutInterval = 7.0;
NSString *const URLMap              = @"http://192.168.195.212/Restaurant/api/tables";
NSString *const URLDownloadMapImage = @"http://192.168.195.212/Restaurant/Images/background.jpg";


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
    
//    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:strRequest]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [_serviceAgent send:URLRequest
          responseBlock:[^(NSData *data, NSError *error) {
              
              // call parser
              MenuModel *entireMenuModel = [MenuDataParser parseEntireMenu:data];
              // call block from hight layer - DataProvider
              callback(entireMenuModel, error);
              
          } copy] ];
}

// get menu data from server
// (int)Id - id of category which we need to get data from it
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
-(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback
{
    NSString *strRequest = [[NSString alloc] initWithFormat:URLMenu, Id];
    
//    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:strRequest]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    __block NSMutableArray *arrCategories;
    
    [_serviceAgent send:URLRequest
          responseBlock:[^(NSData *data, NSError *error) {
              
              // call parser
              arrCategories = [MenuDataParser parseCurrentCategory:data];
              // call block from hight layer - DataProvider
              callback(arrCategories, error);
              
          } copy] ];
}


// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
-(void)downloadImageForItemId:(int)itemId withBlock:(void (^)(UIImage*, NSError*))callback
{
    NSString *strRequest = [[NSString alloc] initWithFormat:URLDownloadImage, itemId];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:strRequest]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [_serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        // call block from hight layer - DataProvider
        callback(image, error);
    } copy] ];
}

// get map data from remote server with help of ServiceAgent
// (void (^)(MapModel*, NSError*)) callback - block which will call when data is
-(void) getEntireMapDataWithResponseBlock:(void (^)(MapModel *, NSError *))callback
{
    //NSString *strRequest =[[NSString alloc] initWithFormat:URLMenu];
    
    //NSURLRequest *URLRequest =[[NSURLRequest requestWithURL:URLMap] ]
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:URLMap]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    [_serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error)
     {
         //MapDataParser *parserForMap=[MapDataParser new];
         MapModel *entireMapModel=[MapDataParser parseEntireMap:data];
         callback (entireMapModel,error);
     } copy]
     ];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
-(void)downloadMapImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    NSString *strRequest = [[NSString alloc] initWithFormat:URLDownloadMapImage];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:strRequest]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [_serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        // call block from hight layer - DataProvider
        callback(image, error);
    } copy] ];
}

@end
