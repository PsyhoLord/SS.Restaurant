//
//  ServiceAgent.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "PServiceAgent.h"

// class ServiceAgent sends request and get response from server

extern NSString *const connectionErrorNotification;
extern NSString *const connectionErrorCode;
extern NSString *const connectionErrorDescription;

@interface ServiceAgent : NSObject<PServiceAgent>

@end
