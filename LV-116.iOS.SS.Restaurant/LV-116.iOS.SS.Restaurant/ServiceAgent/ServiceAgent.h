//
//  ServiceAgent.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PServiceAgent.h"

// class ServiceAgent sends request and get response from server

#define connectionErrorNotification @"connectionErrorNotification"
#define connectionErrorCode         @"connectionErrorCode"
#define connectionErrorDescription  @"connectionErrorDescription"

@interface ServiceAgent : NSObject<PServiceAgent>

@end
