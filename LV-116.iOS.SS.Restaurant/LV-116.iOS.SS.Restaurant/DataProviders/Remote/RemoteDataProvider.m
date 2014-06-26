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

//-(instancetype)init
//{
//    if ( self = [super init] ) {
//        _serviceAgent = [[ServiceAgent alloc] init];
//    }
//    return self;
//}

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
    ServiceAgent *serviceAgent = [[ServiceAgent alloc] init];

    NSString *stringURL = [[NSString alloc] initWithFormat:URLMenu, 0];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];

    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [serviceAgent send:URLRequest
          responseBlock:[^(NSData *data, NSError *error) {
              
              // call parser
              MenuModel *menuModel = [MenuDataParser parseEntireMenu:data];
        
              // call block from hight layer - DataProvider
              callback(menuModel, error);
              
          } copy] ];
}




// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback
{
    
    ServiceAgent *serviceAgent = [[ServiceAgent alloc] init];
    
    NSString *stringURL = [[NSString alloc] initWithFormat:URLDownloadImage, menuItemId];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        // call block from hight layer - DataProvider
        callback(image, error);
        
    } copy] ];
}

#warning It's better to have different RemoteFacade for different areas. I mean MenuRemoteFacade, TableRemoteFacade, etc.
+ (void)loadMapDataWithBlock:(void (^)(MapModel *, NSError *))callback
{
    ServiceAgent *serviceAgent = [[ServiceAgent alloc] init];
    
    NSString *stringURL = [[NSString alloc] initWithFormat:URLMap];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    [serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error) {
        
         //MapDataParser *parserForMap=[MapDataParser new];
         MapModel *entireMapModel=[MapDataParser parseEntireMap:data];
        
         callback (entireMapModel,error);
        
     } copy] ];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    ServiceAgent *serviceAgent = [[ServiceAgent alloc] init];
    
    NSString *stringURL = [[NSString alloc] initWithFormat:URLMap];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [serviceAgent send:URLRequest responseBlock:[^(NSData *data, NSError *error) {
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        // call block from hight layer - DataProvider
        callback(image, error);
        
    } copy] ];
}





/*
 // get menu data from server
 // (int)Id - id of category which we need to get data from it
 // (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
 -(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback
 {
 NSString *url = [[NSString alloc] initWithFormat: URLMenu, Id];
 
 #warning What's an intention of using "cachePolicy:NSURLRequestUseProtocolCachePolicy" ?
 //    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:strRequest]];
 NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:url]
 cachePolicy:NSURLRequestUseProtocolCachePolicy
 timeoutInterval:connectionTimeoutInterval];
 
 #warning Do you really need this variable outside of the block ?
 __block NSMutableArray *arrCategories;
 
 [_serviceAgent send:URLRequest
 responseBlock:[^(NSData *data, NSError *error) {
 
 // call parser
 #warning What if Parse throws an error ? Will a user be notified ???
 arrCategories = [MenuDataParser parseCurrentCategory:data];
 // call block from hight layer - DataProvider
 callback(arrCategories, error);
 
 } copy] ];
 }
 */

@end
