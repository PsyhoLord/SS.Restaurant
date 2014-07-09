//
//  RemoteMapDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteMapDataProvider.h"
#import "RequestManager.h"
#import "MapModel.h"
#import "MapDataParser.h"

static NSString *const kURLMap                  = @"http://192.168.195.212/Restaurant/api/tables";
static NSString *const kURLDownloadMapImage     = @"http://192.168.195.212/Restaurant/Images/background.jpg";
static const CGFloat kConnectionTimeoutInterval = 3.0;
static const int kMaxCountOfAttemptsForRequest  = 3;

@implementation RemoteMapDataProvider

+ (void)loadMapDataWithBlock:(void (^)(MapModel *, NSError *))callback
{
    NSURLRequest *URLRequest = [RemoteMapDataProvider getURLRequestWithstring:[NSString stringWithFormat:kURLMap]
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
    NSURLRequest *URLRequest = [RemoteMapDataProvider
                                getURLRequestWithstring:[NSString stringWithFormat:kURLDownloadMapImage]
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
