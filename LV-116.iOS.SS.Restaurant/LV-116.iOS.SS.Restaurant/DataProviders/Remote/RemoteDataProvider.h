//
//  MenuRemoteDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

#define URLMenu @"http://192.168.195.212/Restaurant/api/Menu?withItems=true&active=true&parentId=%i"

@interface RemoteDataProvider : NSObject

-(instancetype)init;

-(void)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback;

-(void)getEntireMenuDataWithResponseBlock:(void (^)(MenuModel*, NSError*))callback;

@end
