//
//  TripOverviewViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/24/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passLabel <NSObject>
-(void) setLabel:(NSString *) label;
@end

@interface TripOverviewViewController : UIViewController

@property (retain) id <passLabel> delegate;
@property(nonatomic, strong) NSString * name;
@property(nonatomic, strong) NSMutableArray * selectedFlights;
@property(nonatomic, strong) NSString * selectedHotels;
@property(nonatomic, strong) NSString * selectedRestaurants;

@property (nonatomic, weak) IBOutlet UILabel *test_label;

@property (weak, nonatomic) IBOutlet UILabel *flight_label;
@property (weak, nonatomic) IBOutlet UILabel *hotel_label;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_label;

@end
