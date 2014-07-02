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
const int connectionTimeoutInterval = 4.0;
NSString *const URLMap              = @"http://192.168.195.212/Restaurant/api/tables";
NSString *const URLDownloadMapImage = @"http://192.168.195.212/Restaurant/Images/background.jpg";


@implementation RemoteDataProvider

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
    NSString *stringURL = [[NSString alloc] initWithFormat:URLMenu, 0];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [ServiceAgent send:URLRequest
         responseBlock:^(NSData *data, NSError *error) {
             
             MenuModel *menuModel;
             if ( error == nil ) {
                 // call parser
                 
                 menuModel = [MenuDataParser parse: data
                                        parseError: &error];
                 NSLog(@"%@",error);
             }
             // call block from hight layer - DataProvider
             callback(menuModel, error);
             
         } ];
}

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback
{
    NSString *stringURL = [[NSString alloc] initWithFormat:URLDownloadImage, menuItemId];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [ServiceAgent send:URLRequest responseBlock:^(NSData *data, NSError *error) {
        
        UIImage *image;
        if ( error == nil ) {
            image = [[UIImage alloc] initWithData:data];
        }
        // call block from hight layer - DataProvider
        callback(image, error);
        
    } ];
}

+ (void)loadMapDataWithBlock:(void (^)(MapModel *, NSError *))callback
{
    NSString *stringURL = [[NSString alloc] initWithFormat:URLMap];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    [ServiceAgent send:URLRequest responseBlock:^(NSData *data, NSError *error) {
        
        MapModel *mapModel;
        if ( error == nil ) {
            mapModel = [MapDataParser parse: data
                                 parseError: &error];
        }
        callback (mapModel,error);
        
    } ];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    NSString *stringURL = [[NSString alloc] initWithFormat:URLDownloadMapImage];
    
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:connectionTimeoutInterval];
    
    [ServiceAgent send:URLRequest responseBlock:^(NSData *data, NSError *error) {
        
        UIImage *image;
        if ( error == nil ) {
            image = [[UIImage alloc] initWithData: data];
        }
        // call block from hight layer - DataProvider
        callback(image, error);
        
    } ];
}

@end
