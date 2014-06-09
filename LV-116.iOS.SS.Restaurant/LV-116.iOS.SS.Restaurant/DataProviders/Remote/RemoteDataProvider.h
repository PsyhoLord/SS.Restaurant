//
//  MenuRemoteDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteDataProvider : NSObject

-(instancetype)init;

-(NSArray*)getMenuData:(int)Id responseBlock:(void (^)(NSMutableArray*, NSError*))callback;

@end
