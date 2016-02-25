//
//  RestaurantTableViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/23/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripOverviewViewController.h"

@interface RestaurantTableViewController : UITableViewController <passLabel>

@property (strong, nonatomic) NSString * msg;
@property (strong, nonatomic) NSString * selectedHotels;
@property (strong, nonatomic) NSMutableArray * selectedFlights;

@end
