//
//  MainPageTableCell.h
//  TabMain
//
//  Created by Qiankun Zhuang on 2/23/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#ifndef MainPageTripCell_h
#define MainPageTripCell_h
#import <Foundation/Foundation.h>

@interface MainPageTripCell : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *tripId;
@property (strong, nonatomic) NSString *desp;

- (id)initWithUserName: (NSString *)uName andTripId: (NSString *)tId andDesp: (NSString *)tDesp;

@end


#endif /* MainPageTableCell_h */
