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

NSString *const kURLMenu                       = @"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i";
NSString *const kURLDownloadImage              = @"http://192.168.195.212/Restaurant/Menu/ImageResult/%i";
const CGFloat kConnectionTimeoutInterval       = 3.0;
NSString *const kURLMap                        = @"http://192.168.195.212/Restaurant/api/tables";
NSString *const kURLDownloadMapImage           = @"http://192.168.195.212/Restaurant/Images/background.jpg";
static const int kMaxCountOfAttemptsForRequest = 3;


@implementation RemoteDataProvider

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:kURLMenu, 0]
                                                           timeoutInterval:kConnectionTimeoutInterval];
    
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
         countOfAttempts:kMaxCountOfAttemptsForRequest];
}

// download image for itemId
// (int)itemId - Id of item in menu
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMenuItemImageById:(int)menuItemId withBlock:(void (^)(UIImage*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:kURLDownloadImage, menuItemId]
                                                           timeoutInterval:kConnectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData:data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
               
           }
         countOfAttempts:kMaxCountOfAttemptsForRequest];
}

+ (void)loadMapDataWithBlock:(void (^)(MapModel *, NSError *))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:kURLMap]
                                                           timeoutInterval:kConnectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               MapModel *mapModel;
               if ( error == nil ) {
                   mapModel = [MapDataParser parse: data
                                      parsingError: &error];
               }
               callback (mapModel,error);
               
           }
         countOfAttempts:kMaxCountOfAttemptsForRequest];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void)loadMapBackgroundImageWithBlock:(void (^)(UIImage*, NSError*))callback
{
    NSURLRequest *URLRequest = [RemoteDataProvider getURLRequestWithstring:[NSString stringWithFormat:kURLDownloadMapImage]
                                                           timeoutInterval:kConnectionTimeoutInterval];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData: data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
               
           }
         countOfAttempts:kMaxCountOfAttemptsForRequest];
}

+ (NSURLRequest*) getURLRequestWithstring:(NSString*)stringURL timeoutInterval:(CGFloat)timeoutInterval
{
    NSURL *URL = [[NSURL alloc] initWithString:stringURL];
    
    return [NSURLRequest requestWithURL:URL
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:timeoutInterval];
}

@end
