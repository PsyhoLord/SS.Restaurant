//
//  RemoteMapDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteMapDataProvider.h"

#import "RequestManager.h"
#import "RequestMaker.h"

#import "MapModel.h"
#import "MapDataParser.h"

static NSString *const kStringURLMap                = @"http://192.168.195.212/Restaurant/api/tables";
static NSString *const kStringURLDownloadMapImage   = @"http://192.168.195.212/Restaurant/Images/background.jpg";


@implementation RemoteMapDataProvider

+ (void)loadMapDataWithBlock: (void (^)(MapModel *, NSError *))callback
{
    NSURLRequest *URLRequest = [RequestMaker getRequestWithURL: kStringURLMap
                                                       idOfURL: 0];
    
    [RequestManager send: URLRequest
           responseBlock: ^(NSHTTPURLResponse *urlResponse, NSData *data, NSError *error) {
               
               MapModel *mapModel;
               if ( error == nil ) {
                   mapModel = [MapDataParser parse: data
                                      parsingError: &error];
               }
               callback(mapModel,error);
           }
     ];
}

// download image for map
// (void (^)(UIImage*, NSError*))callback - block which will be called when image is
+ (void) loadMapBackgroundImageWithBlock: (void (^)(UIImage*, NSError*))callback
{
    NSURLRequest *urlRequest = [RequestMaker getRequestWithURL: kStringURLDownloadMapImage
                                                       idOfURL: 0];
    
    [RequestManager send: urlRequest
           responseBlock: ^(NSHTTPURLResponse *urlResponse, NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData: data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
           }
     ];
}

@end
