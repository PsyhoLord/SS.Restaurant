//
//  RemoteMenuDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RemoteMenuDataProvider.h"

#import "RequestMaker.h"
#import "RequestManager.h"

#import "MenuDataParser.h"
#import "MenuModel.h"


static NSString *const kURLMenu                 = @"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i";
static NSString *const kURLDownloadImage        = @"http://192.168.195.212/Restaurant/Menu/ImageResult/%i";

static const int kMaxCountOfAttemptsForRequest  = 3;


@implementation RemoteMenuDataProvider

// get all menu tree data from server
// it makes requesst with id = 0
// (void (^)(NSMutableArray*, NSError*))callback - block which will call when data is
+ (void)loadMenuDataWithBlock:(void (^)(MenuModel*, NSError*))callback
{    
    NSURLRequest *URLRequest = [RequestMaker getRequestWithURL: kURLMenu
                                                       idOfURL: 0];
    [RequestManager send: URLRequest
           responseBlock: ^(NSHTTPURLResponse *urlResponse, NSData *data, NSError *error) {
               
               MenuModel *menuModel;
               if ( error == nil ) {
                   // call parser
                   
                   menuModel = [MenuDataParser parse: data
                                        parsingError: &error];
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
    NSURLRequest *URLRequest = [RequestMaker getRequestWithURL: kURLDownloadImage
                                                       idOfURL: menuItemId];
    
    [RequestManager send:URLRequest
           responseBlock:^(NSHTTPURLResponse *urlResponse, NSData *data, NSError *error) {
               
               UIImage *image;
               if ( error == nil ) {
                   image = [[UIImage alloc] initWithData:data];
               }
               // call block from hight layer - DataProvider
               callback(image, error);
               
           }
         countOfAttempts:kMaxCountOfAttemptsForRequest];
}

@end
