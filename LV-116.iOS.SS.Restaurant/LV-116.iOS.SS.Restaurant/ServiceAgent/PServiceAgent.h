//
//  PDataManager.h
//  Test_5
//
//  Created by Administrator on 5/30/14.
//  Copyright (c) 2014 BTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PServiceAgent <NSObject>

-(void)send:(NSURLRequest *)request responseBlock:(void (^)(NSData*, NSError*))callback;

@end
