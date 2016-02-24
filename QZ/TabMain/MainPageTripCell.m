//
//  MainPageTableCell.m
//  TabMain
//
//  Created by Qiankun Zhuang on 2/23/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageTripCell.h"
@implementation MainPageTripCell
@synthesize userName, tripId, desp;

- (id)initWithUserName: (NSString *)uName andTripId: (NSString *)tId andDesp: (NSString *)tDesp
{
    self = [super init];
    if (self) {
        userName = uName;
        tripId = tId;
        desp = tDesp;
    }
    return self;
}
@end