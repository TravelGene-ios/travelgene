//
//  HotelDetailsViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/17/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelDetailsViewController : UIViewController
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSString *hotelAddr;
@property (nonatomic, strong) NSString *hotelImg;

@property (nonatomic, strong) NSString *reviewCnt;
@property (nonatomic, strong) NSString *hotelRating;
@property (nonatomic, strong) NSArray *hotelReviews;

@property (weak, nonatomic) IBOutlet UIImageView *hotel_image_view;
@property (weak, nonatomic) IBOutlet UILabel *hotel_address_label;
@property (weak, nonatomic) IBOutlet UILabel *review_cnt_label;
@property (weak, nonatomic) IBOutlet UILabel *rating_label;
@property (weak, nonatomic) IBOutlet UITableView *review_table_view;

@end
