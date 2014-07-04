//
//  MenuRemoteDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteDataProvider.h"
#import "RequestManager.h"
#import "MenuModel.h"
#import "MapModel.h"
#import "MenuDataParser.h"
#import "MapDataParser.h"

NSString *const URLMenu                       = @"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i";
NSString *const URLDownloadImage              = @"http://192.168.195.212/Restaurant/Menu/ImageResult/%i";
const CGFloat connectionTimeoutInterval       = 3.0;
NSString *const URLMap                        = @"http://192.168.195.212/Restaurant/api/tables";
NSString *const URLDownloadMapImage           = @"http://192.168.195.212/Restaurant/Images/background.jpg";
static const int maxCountOfAttemptsForRequest = 3;


@implementation RemoteDataProvider

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:URLMenu, 0]
                                                           timeoutInterval:connectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               MenuModel *menuModel;
               if ( error == nil ) {
                   // call parser
                   
                   menuModel = [MenuDataParser parse: data
                                        parsingError: &error];
                   NSLog(@"%@",error);
               }
               // call block from hight layer - DataProvider
               callback(menuModel, error);
               
           }
         countOfAttempts:maxCountOfAttemptsForRequest];
}

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:URLDownloadImage, menuItemId]
                                                           timeoutInterval:connectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData:data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
               
           }
         countOfAttempts:maxCountOfAttemptsForRequest];
}

+ (void)loadMapDataWithBlock:(void (^)(MapModel *, NSError *))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:URLMap]
                                                           timeoutInterval:connectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               MapModel *mapModel;
               if ( error == nil ) {
                   mapModel = [MapDataParser parse: data
                                      parsingError: &error];
               }
               callback (mapModel,error);
               
           }
         countOfAttempts:maxCountOfAttemptsForRequest];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:URLDownloadMapImage]
                                                           timeoutInterval:connectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData: data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
               
           }
         countOfAttempts:maxCountOfAttemptsForRequest];
}

+ (NSURLRequest*) getURLRequestWithstring:(NSString*)stringURL timeoutInterval:(CGFloat)timeoutInterval
{
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    return [NSURLRequest requestWithURL:URL
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:timeoutInterval];
}

@end
